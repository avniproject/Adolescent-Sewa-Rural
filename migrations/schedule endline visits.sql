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
select '{}'::jsonb,now(),null,dt.program_enrolment_id,uuid_generate_v4(),0,
 1349,'Annual Visit - Endline',now(),233,null,'{}'::jsonb,dt.created_by_id,
 false,null,null,null,dt.created_by_id,dt.last_modified_by_id,now(),
 now(),dt.address_id,dt.individual_id,null,null
from to_be_scheduled dt;
