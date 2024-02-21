set role adsr;

--To update the current standard (which is the decision concept triggered from the 'Annual Visit - Baseline' program encounter), 
--we retrieve the latest details from the 'In which standard he/she is studying?' question in the 'Annual Visit - Baseline' program encounter and 
--then update the 'Current Standard' in the decision encounter.
--We are taking the dropout details from the Baseline and Endline encounters. If a student has dropped out, then update the 'Current Standard' as 'Dropped out'.

-- If you intend to make changes in the production environment, please modify the program id and last modified by id.
   

----------------------------------------------------------------------------------------------------------------------------------------------------
--Update Query
with annual_visits_base as(
	SELECT 
	    id,
	    individual_id,
	    program_enrolment_id,
	    encounter_date_time,
	    observations obs
	FROM public.program_encounter pe 
	WHERE pe.encounter_type_id = (SELECT id FROM public.encounter_type et WHERE et.name = 'Annual Visit - Endline' AND et.is_voided = false)
	    AND pe.encounter_date_time IS NOT NULL 
	    AND pe.observations -> '9705f6ad-50e1-4179-aa60-922014d7cc3c'::text = '"fb1080b4-d1ec-4c87-a10d-3838ba9abc5b"'
	union all 
	SELECT 
	    id,
	    individual_id,
	    program_enrolment_id,
	    encounter_date_time,
	    observations obs
	FROM public.program_encounter pe 
	WHERE pe.encounter_type_id = (SELECT id FROM public.encounter_type et WHERE et.name = 'Annual Visit - Baseline' AND et.is_voided = false)
	    AND pe.encounter_date_time IS NOT NULL
),
annual_visits as(
	SELECT 
	    id,
	    individual_id,
	    program_enrolment_id,
	    encounter_date_time,
	    obs,
	    ROW_NUMBER() OVER (PARTITION BY enc.individual_id ORDER BY enc.encounter_date_time DESC NULLS LAST) AS visit_number
	from annual_visits_base enc
)
UPDATE public.program_enrolment AS enrol
SET observations = 
    CASE 
	    WHEN (enc.obs -> '9705f6ad-50e1-4179-aa60-922014d7cc3c')::TEXT = '"fb1080b4-d1ec-4c87-a10d-3838ba9abc5b"' OR 
             (enc.obs -> '9705f6ad-50e1-4179-aa60-922014d7cc3c') IS NULL THEN 
            enrol.observations || jsonb_build_object('67b7a434-fdc7-44b6-89e7-b4755afd0bc3', '"fb1080b4-d1ec-4c87-a10d-3838ba9abc5b"')
        WHEN (enc.obs -> '9705f6ad-50e1-4179-aa60-922014d7cc3c')::TEXT = '"995cfaee-5598-4293-addc-dcb1da5dbcd3"' THEN 
            enrol.observations || jsonb_build_object('67b7a434-fdc7-44b6-89e7-b4755afd0bc3', enc.obs -> '2424293e-2466-4122-970f-716f3019ad55')
        ELSE enrol.observations
    END,
    last_modified_date_time = current_timestamp + ((enrol.id % 1000) * interval '1 millisecond'),
    last_modified_by_id = 5327,
    manual_update_history = append_manual_update_history(enrol.manual_update_history, ' Updating the program decision concept Current Standard for old data as per #24 card')
FROM annual_visits AS enc
WHERE enc.program_enrolment_id = enrol.id
    AND enc.visit_number = 1
    AND enrol.program_id = 299;


----------------------------------------------------------------------------------------------------------------------------------------------------
--Select Query
with annual_visits_base as(
	SELECT 
	    id,
	    individual_id,
	    program_enrolment_id,
	    encounter_date_time,
	    observations obs
	FROM public.program_encounter pe 
	WHERE pe.encounter_type_id = (SELECT id FROM public.encounter_type et WHERE et.name = 'Annual Visit - Endline' AND et.is_voided = false)
	    AND pe.encounter_date_time IS NOT null
	    AND pe.observations -> '9705f6ad-50e1-4179-aa60-922014d7cc3c'::text = '"fb1080b4-d1ec-4c87-a10d-3838ba9abc5b"'
	union all 
	SELECT 
	    id,
	    individual_id,
	    program_enrolment_id,
	    encounter_date_time,
	    observations obs
	FROM public.program_encounter pe 
	WHERE pe.encounter_type_id = (SELECT id FROM public.encounter_type et WHERE et.name = 'Annual Visit - Baseline' AND et.is_voided = false)
	    AND pe.encounter_date_time IS NOT null
),
annual_visits as(
	SELECT 
	    id,
	    individual_id,
	    program_enrolment_id,
	    encounter_date_time,
	    obs,
	    ROW_NUMBER() OVER (PARTITION BY enc.individual_id ORDER BY enc.encounter_date_time DESC NULLS LAST) AS visit_number
	from annual_visits_base enc
)
SELECT 
    enrol.id AS enrolment_id,
    enc.id,
    enc.individual_id,
 	enrol.observations as enrol_obs, -- It will be empty
    (enc.obs -> '9705f6ad-50e1-4179-aa60-922014d7cc3c')::text as obs,
    CASE 
	    WHEN (enc.obs -> '9705f6ad-50e1-4179-aa60-922014d7cc3c')::TEXT = '"fb1080b4-d1ec-4c87-a10d-3838ba9abc5b"' OR 
             (enc.obs -> '9705f6ad-50e1-4179-aa60-922014d7cc3c') IS NULL THEN
            'Dropped Out'
        WHEN (enc.obs -> '9705f6ad-50e1-4179-aa60-922014d7cc3c')::TEXT = '"995cfaee-5598-4293-addc-dcb1da5dbcd3"' THEN 
            'Yes'
        ELSE 'Unknown'
    END AS updated_observations,
    current_timestamp + ((enrol.id % 1000) * interval '1 millisecond') AS last_modified_date_time,
    5327 AS last_modified_by_id,
    append_manual_update_history(enrol.manual_update_history, ' Updating the program decision concept Current Standard for old data as per #24 card') AS updated_manual_history
FROM public.program_enrolment AS enrol
JOIN annual_visits AS enc ON enc.program_enrolment_id = enrol.id
WHERE enc.visit_number = 1
    AND enrol.program_id = 299; -- 5674
