-- Zenhub card link - https://app.zenhub.com/workspaces/avni-impl--support-5cf8e458bf08585333fd64ac/issues/gh/avniproject/sewa-rural/208

-- Ticket link - https://avni.freshdesk.com/a/tickets/2777

-- Adolescent Sewa rural didn't have the encounter "Annual visit - Baseline Encounter" scheduled at endline, so they want to schedule the "Baseline" encounter for those who have completed the "Endline" encounter.

set role adsr;

-- To get the id of the Endline encounter.
select * from encounter_type et where name = 'Annual Visit - Endline' ; -- id = 1349;

-- To get the id of the Baseline encoutner.
select * from encounter_type et where name = 'Annual Visit - Baseline'; -- id = 1343;

-- Query to check the number of individuals that can be affected
select count(pe.individual_id)
from program_encounter pe 
where encounter_type_id = 1349 
and extract ( year from encounter_date_time::date) = 2023
;
-- 2484 Adolescents have completed their endline this year. Hence 2484 "Endline" encounters will be scheduled.

with individuals_to_be_scheduled as (
select pe.*
from program_encounter pe 
inner join individual i on i.id = pe.individual_id 
where encounter_type_id = 1349 
and i.is_voided is false 
and extract ( year from encounter_date_time::date) = 2023
)
insert into program_encounter (observations,earliest_visit_date_time,
encounter_date_time,program_enrolment_id,
uuid,"version",encounter_type_id,
name,max_visit_date_time,organisation_id,
cancel_date_time,cancel_observations,
audit_id,is_voided,encounter_location,
cancel_location,legacy_id,created_by_id,
last_modified_by_id, created_date_time ,
 last_modified_date_time,address_id,
 individual_id,sync_concept_1_value,
 sync_concept_2_value,manual_update_history)
select '{}'::jsonb, now() + interval '1 day',
 null, program_enrolment_id,
 uuid_generate_v4(), 0, 1343,
 'Annual Visit - Baseline', now() + interval '4 day', organisation_id ,
 null, '{}'::jsonb,
 audit_id , false,null,
 null, null, created_by_id,
 last_modified_by_id, current_timestamp + (random() * interval '2 millisecond') ,
 current_timestamp + (random() * interval '2 millisecond'), address_id ,
 individual_id , null,
 null,null
from individuals_to_be_scheduled;

-- On running this query, the individuals have completed their "Endline encounter" this year will have been scheduled "Baseline encounter" dated 15 June 2023.
