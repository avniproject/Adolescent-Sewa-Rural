set role adsr;

select * from concept where uuid = '9705f6ad-50e1-4179-aa60-922014d7cc3c'; -- Going to school
select * from concept where uuid = 'fb1080b4-d1ec-4c87-a10d-3838ba9abc5b'; -- Dropped out
select * from encounter_type where id = 1343; -- Annual Visit - Baseline
select * from encounter_type where id = 1349; -- Annual Visit - Endline

-- Students for whom Going to school = Dropped out in the "Annual Visit - Baseline" form
select
    count(distinct individual_id)
from program_encounter
where program_encounter.observations->>'9705f6ad-50e1-4179-aa60-922014d7cc3c' = 'fb1080b4-d1ec-4c87-a10d-3838ba9abc5b'
  and encounter_type_id  = 1343 and is_voided is false;

-- Actual list of students
select
    individual_id ,
    address_id,
    created_by_id,
    last_modified_by_id,
    program_enrolment_id
from program_encounter
where program_encounter.observations->>'9705f6ad-50e1-4179-aa60-922014d7cc3c' = 'fb1080b4-d1ec-4c87-a10d-3838ba9abc5b'
  and encounter_type_id  = 1343 and is_voided is false;

-- Check if these baselines already have an endline encounter. This should have zero results
select *
from program_encounter baseline
inner join program_encounter endline on baseline.individual_id = endline.individual_id and baseline.program_enrolment_id = endline.program_enrolment_id
and baseline.encounter_type_id  = 1343 and endline.encounter_type_id = 1349 and baseline.is_voided is false and endline.is_voided is false
where baseline.observations->>'9705f6ad-50e1-4179-aa60-922014d7cc3c' = 'fb1080b4-d1ec-4c87-a10d-3838ba9abc5b';

-- Create new endline encounters for these students
with to_be_scheduled as (
    select
        individual_id ,
        address_id,
        created_by_id,
        last_modified_by_id,
        program_enrolment_id
    from program_encounter
    where program_encounter.observations->>'9705f6ad-50e1-4179-aa60-922014d7cc3c' = 'fb1080b4-d1ec-4c87-a10d-3838ba9abc5b'
      and encounter_type_id  = 1343
)
insert into program_encounter (observations,earliest_visit_date_time,encounter_date_time ,program_enrolment_id,uuid,"version",
                               encounter_type_id,"name",max_visit_date_time,organisation_id,cancel_date_time ,cancel_observations ,audit_id ,is_voided ,
                               encounter_location ,cancel_location ,legacy_id ,created_by_id ,last_modified_by_id ,created_date_time ,last_modified_date_time ,
                               address_id ,individual_id, sync_concept_1_value ,sync_concept_2_value )
select '{}'::jsonb,now(),null,
       baseline.program_enrolment_id,uuid_generate_v4(),0,
       1349,'Annual Visit - Endline',now(),233,null,'{}'::jsonb,
       create_audit(),
       false,null,null,null,
       baseline.created_by_id,
       baseline.last_modified_by_id,now(),
       now(),
       baseline.address_id,
       baseline.individual_id,null,null
from to_be_scheduled baseline;


-- Confirm that we now have endlines for all baselines where students have dropped out. This query should return 132 rows
select *
from program_encounter baseline
         inner join program_encounter endline on baseline.individual_id = endline.individual_id and baseline.program_enrolment_id = endline.program_enrolment_id
    and baseline.encounter_type_id  = 1343 and endline.encounter_type_id = 1349 and baseline.is_voided is false and endline.is_voided is false
where baseline.observations->>'9705f6ad-50e1-4179-aa60-922014d7cc3c' = 'fb1080b4-d1ec-4c87-a10d-3838ba9abc5b';

commit;

select * from adsr.individual_adolescent_annual_visit_baseline where "Going to school" = 'Dropped out'

select * from adsr.individual i where id = 961842;
