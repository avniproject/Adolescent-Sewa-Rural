---------------------FOR UAT ORG-----------------------

-- Script to convert the single select coded concept to multi select coded concept, in this case, the name of the field is "Do you have any addiction"

set role aduat;

select * from encounter_type et where name = 'Annual Visit - Baseline'; -- id = 1299

select * from encounter_type et where name = 'Annual Visit - Endline'; -- id = 1305

select * from encounter_type et where name = 'Severe Malnutrition Follow-up'; -- id = 1300

select * from concept where name = 'Do you have any addiction'; -- uuid = '8fc337d4-9809-4de1-8cbc-611a40c07653'

select * from users where username = 'taqi@aduat'; -- id = 5090

-- Actual script to convert the single select coded concept to multi select coded concept

update program_encounter 
set observations = observations || json_build_object('8fc337d4-9809-4de1-8cbc-611a40c07653',
                                                     array [observations ->> '8fc337d4-9809-4de1-8cbc-611a40c07653'])::jsonb,
    last_modified_by_id = 5090,
    last_modified_date_time = now()
where observations ->> '8fc337d4-9809-4de1-8cbc-611a40c07653' is not null
and encounter_type_id in (1299,1305,1300);

----- Script to edit the individuals who have selected the answer 'Both' for the question 'Do you have any addiction'.
 
select * from concept where name = 'Both'; -- uuid = '47766246-d271-4058-adcc-b6a24189580a'

select * from concept where name = 'Alcohol'; -- uuid = 'ebe4b9f1-d007-4605-a952-42d51d2b8de1'

select * from concept where name = 'Tobacco'; -- uuid = '99199654-0555-4734-ad62-46728bb16ec8'


------ Actual script to update the answer to 'Alcohol' and 'Tobacco' for those who have selected 'Both' as an answer

update program_encounter 
set observations = observations || json_build_object('8fc337d4-9809-4de1-8cbc-611a40c07653',
                                                     array ['ebe4b9f1-d007-4605-a952-42d51d2b8de1','99199654-0555-4734-ad62-46728bb16ec8'])::jsonb,
    last_modified_by_id = 5090,
    last_modified_date_time = now()
where observations ->> '8fc337d4-9809-4de1-8cbc-611a40c07653' = '47766246-d271-4058-adcc-b6a24189580a'
and encounter_type_id in (1299,1305,1300);

-- To verify if the changes were actually made, run the below query to verify

 select * from program_encounter pe 
where observations ->> '8fc337d4-9809-4de1-8cbc-611a40c07653' = '47766246-d271-4058-adcc-b6a24189580a'
and encounter_type_id in (1299,1305,1300)
;




--------------------------------FOR PROD ORG-----------------------------------

-- Script to convert the single select coded concept to multi select coded concept, in this case, the name of the field is "Do you have any addiction"

set role adsr;

select * from encounter_type et where name = 'Annual Visit - Baseline'; -- id = 1343

select * from encounter_type et where name = 'Annual Visit - Endline'; -- id = 1349

select * from encounter_type et where name = 'Severe Malnutrition Follow-up'; -- id = 1344

select * from concept where name = 'Do you have any addiction'; -- uuid = '8fc337d4-9809-4de1-8cbc-611a40c07653'

select * from users where username = 'taqi@adsr'; -- id = 5327

-- Actual script to convert the single select coded concept to multi select coded concept

update program_encounter 
set observations = observations || json_build_object('8fc337d4-9809-4de1-8cbc-611a40c07653',
                                                     array [observations ->> '8fc337d4-9809-4de1-8cbc-611a40c07653'])::jsonb,
    last_modified_by_id = 5327,
    last_modified_date_time = now()
where observations ->> '8fc337d4-9809-4de1-8cbc-611a40c07653' is not null
and encounter_type_id in (1343, 1349, 1344);

----- Script to edit the individuals who have selected the answer 'Both' for the question 'Do you have any addiction'.
 
select * from concept where name = 'Both'; -- uuid = '47766246-d271-4058-adcc-b6a24189580a'

select * from concept where name = 'Alcohol'; -- uuid = 'ebe4b9f1-d007-4605-a952-42d51d2b8de1'

select * from concept where name = 'Tobacco'; -- uuid = '99199654-0555-4734-ad62-46728bb16ec8'


------ Actual script to update the answer to 'Alcohol' and 'Tobacco' for those who have selected 'Both' as an answer

update program_encounter 
set observations = observations || json_build_object('8fc337d4-9809-4de1-8cbc-611a40c07653',
                                                     array ['ebe4b9f1-d007-4605-a952-42d51d2b8de1','99199654-0555-4734-ad62-46728bb16ec8'])::jsonb,
    last_modified_by_id = 5327,
    last_modified_date_time = now()
where observations ->> '8fc337d4-9809-4de1-8cbc-611a40c07653' = '47766246-d271-4058-adcc-b6a24189580a'
and encounter_type_id in (1343, 1349, 1344);

-- To verify if the changes were actually made, run the below query to verify

 select * from program_encounter pe 
where observations ->> '8fc337d4-9809-4de1-8cbc-611a40c07653' = '47766246-d271-4058-adcc-b6a24189580a'
and encounter_type_id in (1343, 1349, 1344)
;

