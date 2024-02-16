set role adsruat;

--To update the current standard (which is the decision concept triggered from the 'Annual Visit - Baseline' program encounter), 
--we retrieve the latest details from the 'In which standard he/she is studying?' question in the 'Annual Visit - Baseline' program encounter and 
--then update the 'Current Standard' in the decision encounter.

-- If you intend to make changes in the production environment, please modify the organization name and last modified by id.
   
WITH baseline_encounters AS (
    SELECT 
        id,
        program_enrolment_id,
        observations obs,
        ROW_NUMBER() OVER (PARTITION BY pe.individual_id ORDER BY pe.encounter_date_time DESC NULLS LAST) AS visit_number
    FROM program_encounter pe 
    WHERE pe.encounter_type_id = (SELECT id FROM encounter_type et WHERE et.name = 'Annual Visit - Baseline' AND et.is_voided = false)
        AND pe.encounter_date_time IS NOT NULL 
)
UPDATE public.program_enrolment AS enrol
SET observations = 
    CASE 
        WHEN (enc.obs -> '9705f6ad-50e1-4179-aa60-922014d7cc3c')::TEXT = '"995cfaee-5598-4293-addc-dcb1da5dbcd3"' THEN 
            enrol.observations || jsonb_build_object('67b7a434-fdc7-44b6-89e7-b4755afd0bc3', enc.obs -> '2424293e-2466-4122-970f-716f3019ad55')
        WHEN (enc.obs -> '9705f6ad-50e1-4179-aa60-922014d7cc3c')::TEXT = '"fb1080b4-d1ec-4c87-a10d-3838ba9abc5b"' OR 
             (enc.obs -> '9705f6ad-50e1-4179-aa60-922014d7cc3c') IS NULL THEN 
            enrol.observations || jsonb_build_object('67b7a434-fdc7-44b6-89e7-b4755afd0bc3', '"fb1080b4-d1ec-4c87-a10d-3838ba9abc5b"')
        ELSE enrol.observations
    END,
    last_modified_date_time = current_timestamp + ((enrol.id % 1000) * interval '1 millisecond'),
    last_modified_by_id = 10366,
    manual_update_history = manual_update_history || ', Updating the program decision concept Current Standard for old data as per #24 card'
FROM baseline_encounters AS enc
WHERE enc.program_enrolment_id = enrol.id
    AND enc.visit_number = 1
    AND enrol.program_id = 975;







----------------------- On Endline

set role adsruat;

WITH endline_encounters AS (
    SELECT 
        id,
        program_enrolment_id,
        observations obs,
        ROW_NUMBER() OVER (PARTITION BY pe.individual_id ORDER BY pe.encounter_date_time DESC NULLS LAST) AS visit_number
    FROM program_encounter pe 
    WHERE pe.encounter_type_id = (SELECT id FROM encounter_type et WHERE et.name = 'Annual Visit - Endline' AND et.is_voided = false)
        AND pe.encounter_date_time IS NOT NULL 
        and (pe.observations -> '9705f6ad-50e1-4179-aa60-922014d7cc3c')::TEXT = '"fb1080b4-d1ec-4c87-a10d-3838ba9abc5b"'
)
UPDATE public.program_enrolment AS enrol
SET observations = enrol.observations || jsonb_build_object('67b7a434-fdc7-44b6-89e7-b4755afd0bc3', '"fb1080b4-d1ec-4c87-a10d-3838ba9abc5b"'),
    last_modified_date_time = current_timestamp + ((enrol.id % 1000) * interval '1 millisecond'),
    last_modified_by_id = 10366,
    manual_update_history = manual_update_history || ', Updating the program decision concept Current Standard for old data as per #24 card'
FROM endline_encounters AS enc
WHERE enc.program_enrolment_id = enrol.id
    AND enc.visit_number = 1
    AND enrol.program_id = 975;
