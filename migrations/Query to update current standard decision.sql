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
SET observations = enrol.observations || jsonb_build_object('67b7a434-fdc7-44b6-89e7-b4755afd0bc3', enc.obs -> '2424293e-2466-4122-970f-716f3019ad55'), 
    last_modified_date_time = current_timestamp + ((enrol.id % 1000) * interval '1 millisecond'),
    last_modified_by_id = 10366;
FROM baseline_encounters AS enc
WHERE enc.program_enrolment_id = enrol.id
    AND enc.visit_number = 1
    AND enrol.organisation_id = (SELECT id FROM public.organisation o WHERE o.name = 'Adolescent Sewa Rural UAT' LIMIT 1)
    AND enrol.program_id = (SELECT id FROM public."program" prgrm WHERE prgrm.name = 'Adolescent')
    AND (enc.obs -> '9705f6ad-50e1-4179-aa60-922014d7cc3c')::TEXT = '"995cfaee-5598-4293-addc-dcb1da5dbcd3"'
    AND enrol.observations -> '67b7a434-fdc7-44b6-89e7-b4755afd0bc3' is null;
