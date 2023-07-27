set role adsruat;


select * from encounter_type where name = 'Annual Visit - Baseline';
-- 13789aa4-8537-4d5d-8ca8-4012e7585152
-- 2464

select * from encounter_type where name = 'Annual Visit - Endline';
-- d2744e14-470d-464e-b97e-967ce770bc53
-- 2470

select * from encounter_type where name = 'Severe Anemia Follow-up';
-- 8c8019b6-f429-4fdb-9374-cacde0a6e6fe
-- 2466

select * from encounter_type where name = 'Moderate Anemia Follow-up';
-- a30de3b7-873c-4475-aa2c-cc28d35a277f
-- 2467


select *
from concept where name = 'Anaemic status';
-- d304f306-deca-4418-a9a5-27b04e083623
-- 194254

select *
from concept where name = 'Severe anaemia';
-- 1f92d18a-2c91-4421-8c41-2cc56f799c6d
-- 194166

select *
from concept where name = 'Moderate anaemia';
-- 830319d4-b616-4253-88ff-00ada2b3ff03
-- 194089


--1: Annual Visit - Baseline


-- start query for severe anemia

select count(*)
from program_encounter
where encounter_type_id = (select id from encounter_type where name = 'Annual Visit - Baseline')
  and (observations->>'0f283bcc-fa4c-4d98-93fd-cbf1729b770d')::numeric <= 8;

-- add Anaemic status as Severe anaemia for Haemoglobin <= 8
update program_encounter
set observations = observations || '{"d304f306-deca-4418-a9a5-27b04e083623": ["1f92d18a-2c91-4421-8c41-2cc56f799c6d"]}',
    last_modified_date_time = current_timestamp + ((random() * 10 + 1) * interval '1 millisecond'),
    manual_update_history = 'set Anaemic status as Severe anaemia for Haemoglobin <= 8'
where encounter_type_id = (select id from encounter_type where name = 'Annual Visit - Baseline')
  and (observations->>'0f283bcc-fa4c-4d98-93fd-cbf1729b770d')::numeric <= 8;


-- verification query after update
select count(*)
from program_encounter
where encounter_type_id = (select id from encounter_type where name = 'Annual Visit - Baseline')
  and (observations->>'0f283bcc-fa4c-4d98-93fd-cbf1729b770d')::numeric <= 8
  and observations->>'d304f306-deca-4418-a9a5-27b04e083623' = '["1f92d18a-2c91-4421-8c41-2cc56f799c6d"]'  ;


-- start query for moderate anemia

select count(*)
from program_encounter
where encounter_type_id = (select id from encounter_type where name = 'Annual Visit - Baseline')
  and (observations->>'0f283bcc-fa4c-4d98-93fd-cbf1729b770d')::numeric > 8 and (observations->>'0f283bcc-fa4c-4d98-93fd-cbf1729b770d')::numeric < 11;

-- add Anaemic status as Severe anaemia for Haemoglobin > 8 and < 11
update program_encounter
set observations = observations || '{"d304f306-deca-4418-a9a5-27b04e083623": ["830319d4-b616-4253-88ff-00ada2b3ff03"]}',
    last_modified_date_time = current_timestamp + ((random() * 10 + 1) * interval '1 millisecond'),
    manual_update_history = 'set Anaemic status as moderate anaemia for Haemoglobin > 8 and Haemoglobin < 11'
where encounter_type_id = (select id from encounter_type where name = 'Annual Visit - Baseline')
  and (observations->>'0f283bcc-fa4c-4d98-93fd-cbf1729b770d')::numeric > 8 and (observations->>'0f283bcc-fa4c-4d98-93fd-cbf1729b770d')::numeric < 11;


-- verification query after update
select count(*)
from program_encounter
where encounter_type_id = (select id from encounter_type where name = 'Annual Visit - Baseline')
  and (observations->>'0f283bcc-fa4c-4d98-93fd-cbf1729b770d')::numeric > 8 and (observations->>'0f283bcc-fa4c-4d98-93fd-cbf1729b770d')::numeric < 11
  and observations->>'d304f306-deca-4418-a9a5-27b04e083623' = '["830319d4-b616-4253-88ff-00ada2b3ff03"]' ;



--2: Annual Visit - Endline


-- start query for severe anemia

select count(*)
from program_encounter
where encounter_type_id = (select id from encounter_type where name = 'Annual Visit - Endline')
  and (observations->>'0f283bcc-fa4c-4d98-93fd-cbf1729b770d')::numeric <= 8;

-- add Anaemic status as Severe anaemia for Haemoglobin <= 8
update program_encounter
set observations = observations || '{"d304f306-deca-4418-a9a5-27b04e083623": ["1f92d18a-2c91-4421-8c41-2cc56f799c6d"]}',
    last_modified_date_time = current_timestamp + ((random() * 10 + 1) * interval '1 millisecond'),
    manual_update_history = 'set Anaemic status as Severe anaemia for Haemoglobin <= 8'
where encounter_type_id = (select id from encounter_type where name = 'Annual Visit - Endline')
  and (observations->>'0f283bcc-fa4c-4d98-93fd-cbf1729b770d')::numeric <= 8;


-- verification query after update
select count(*)
from program_encounter
where encounter_type_id = (select id from encounter_type where name = 'Annual Visit - Endline')
  and (observations->>'0f283bcc-fa4c-4d98-93fd-cbf1729b770d')::numeric <= 8
  and observations->>'d304f306-deca-4418-a9a5-27b04e083623' = '["1f92d18a-2c91-4421-8c41-2cc56f799c6d"]'  ;


-- start query for moderate anemia

select count(*)
from program_encounter
where encounter_type_id = (select id from encounter_type where name = 'Annual Visit - Endline')
  and (observations->>'0f283bcc-fa4c-4d98-93fd-cbf1729b770d')::numeric > 8 and (observations->>'0f283bcc-fa4c-4d98-93fd-cbf1729b770d')::numeric < 11;

-- add Anaemic status as Severe anaemia for Haemoglobin > 8 and < 11
update program_encounter
set observations = observations || '{"d304f306-deca-4418-a9a5-27b04e083623": ["830319d4-b616-4253-88ff-00ada2b3ff03"]}',
    last_modified_date_time = current_timestamp + ((random() * 10 + 1) * interval '1 millisecond'),
    manual_update_history = 'set Anaemic status as moderate anaemia for Haemoglobin > 8 and Haemoglobin < 11'
where encounter_type_id = (select id from encounter_type where name = 'Annual Visit - Endline')
  and (observations->>'0f283bcc-fa4c-4d98-93fd-cbf1729b770d')::numeric > 8 and (observations->>'0f283bcc-fa4c-4d98-93fd-cbf1729b770d')::numeric < 11;


-- verification query after update
select count(*)
from program_encounter
where encounter_type_id = (select id from encounter_type where name = 'Annual Visit - Endline')
  and (observations->>'0f283bcc-fa4c-4d98-93fd-cbf1729b770d')::numeric > 8 and (observations->>'0f283bcc-fa4c-4d98-93fd-cbf1729b770d')::numeric < 11
  and observations->>'d304f306-deca-4418-a9a5-27b04e083623' = '["830319d4-b616-4253-88ff-00ada2b3ff03"]' ;


--3: Severe Anemia Follow-up


-- start query for severe anemia

select count(*)
from program_encounter
where encounter_type_id = (select id from encounter_type where name = 'Severe Anemia Follow-up')
  and (observations->>'0f283bcc-fa4c-4d98-93fd-cbf1729b770d')::numeric <= 8;

-- add Anaemic status as Severe anaemia for Haemoglobin <= 8
update program_encounter
set observations = observations || '{"d304f306-deca-4418-a9a5-27b04e083623": ["1f92d18a-2c91-4421-8c41-2cc56f799c6d"]}',
    last_modified_date_time = current_timestamp + ((random() * 10 + 1) * interval '1 millisecond'),
    manual_update_history = 'set Anaemic status as Severe anaemia for Haemoglobin <= 8'
where encounter_type_id = (select id from encounter_type where name = 'Severe Anemia Follow-up')
  and (observations->>'0f283bcc-fa4c-4d98-93fd-cbf1729b770d')::numeric <= 8;


-- verification query after update
select count(*)
from program_encounter
where encounter_type_id = (select id from encounter_type where name = 'Severe Anemia Follow-up')
  and (observations->>'0f283bcc-fa4c-4d98-93fd-cbf1729b770d')::numeric <= 8
  and observations->>'d304f306-deca-4418-a9a5-27b04e083623' = '["1f92d18a-2c91-4421-8c41-2cc56f799c6d"]'  ;


-- start query for moderate anemia

select count(*)
from program_encounter
where encounter_type_id = (select id from encounter_type where name = 'Severe Anemia Follow-up')
  and (observations->>'0f283bcc-fa4c-4d98-93fd-cbf1729b770d')::numeric > 8 and (observations->>'0f283bcc-fa4c-4d98-93fd-cbf1729b770d')::numeric < 11;

-- add Anaemic status as Severe anaemia for Haemoglobin > 8 and < 11
update program_encounter
set observations = observations || '{"d304f306-deca-4418-a9a5-27b04e083623": ["830319d4-b616-4253-88ff-00ada2b3ff03"]}',
    last_modified_date_time = current_timestamp + ((random() * 10 + 1) * interval '1 millisecond'),
    manual_update_history = 'set Anaemic status as moderate anaemia for Haemoglobin > 8 and Haemoglobin < 11'
where encounter_type_id = (select id from encounter_type where name = 'Severe Anemia Follow-up')
  and (observations->>'0f283bcc-fa4c-4d98-93fd-cbf1729b770d')::numeric > 8 and (observations->>'0f283bcc-fa4c-4d98-93fd-cbf1729b770d')::numeric < 11;


-- verification query after update
select count(*)
from program_encounter
where encounter_type_id = (select id from encounter_type where name = 'Severe Anemia Follow-up')
  and (observations->>'0f283bcc-fa4c-4d98-93fd-cbf1729b770d')::numeric > 8 and (observations->>'0f283bcc-fa4c-4d98-93fd-cbf1729b770d')::numeric < 11
  and observations->>'d304f306-deca-4418-a9a5-27b04e083623' = '["830319d4-b616-4253-88ff-00ada2b3ff03"]' ;


--4: Moderate Anemia Follow-up


-- start query for severe anemia

select count(*)
from program_encounter
where encounter_type_id = (select id from encounter_type where name = 'Moderate Anemia Follow-up')
  and (observations->>'0f283bcc-fa4c-4d98-93fd-cbf1729b770d')::numeric <= 8;

-- add Anaemic status as Severe anaemia for Haemoglobin <= 8
update program_encounter
set observations = observations || '{"d304f306-deca-4418-a9a5-27b04e083623": ["1f92d18a-2c91-4421-8c41-2cc56f799c6d"]}',
    last_modified_date_time = current_timestamp + ((random() * 10 + 1) * interval '1 millisecond'),
    manual_update_history = 'set Anaemic status as Severe anaemia for Haemoglobin <= 8'
where encounter_type_id = (select id from encounter_type where name = 'Moderate Anemia Follow-up')
  and (observations->>'0f283bcc-fa4c-4d98-93fd-cbf1729b770d')::numeric <= 8;


-- verification query after update
select count(*)
from program_encounter
where encounter_type_id = (select id from encounter_type where name = 'Moderate Anemia Follow-up')
  and (observations->>'0f283bcc-fa4c-4d98-93fd-cbf1729b770d')::numeric <= 8
  and observations->>'d304f306-deca-4418-a9a5-27b04e083623' = '["1f92d18a-2c91-4421-8c41-2cc56f799c6d"]'  ;


-- start query for moderate anemia

select count(*)
from program_encounter
where encounter_type_id = (select id from encounter_type where name = 'Moderate Anemia Follow-up')
  and (observations->>'0f283bcc-fa4c-4d98-93fd-cbf1729b770d')::numeric > 8 and (observations->>'0f283bcc-fa4c-4d98-93fd-cbf1729b770d')::numeric < 11;

-- add Anaemic status as Severe anaemia for Haemoglobin > 8 and < 11
update program_encounter
set observations = observations || '{"d304f306-deca-4418-a9a5-27b04e083623": ["830319d4-b616-4253-88ff-00ada2b3ff03"]}',
    last_modified_date_time = current_timestamp + ((random() * 10 + 1) * interval '1 millisecond'),
    manual_update_history = 'set Anaemic status as moderate anaemia for Haemoglobin > 8 and Haemoglobin < 11'
where encounter_type_id = (select id from encounter_type where name = 'Moderate Anemia Follow-up')
  and (observations->>'0f283bcc-fa4c-4d98-93fd-cbf1729b770d')::numeric > 8 and (observations->>'0f283bcc-fa4c-4d98-93fd-cbf1729b770d')::numeric < 11;


-- verification query after update
select count(*)
from program_encounter
where encounter_type_id = (select id from encounter_type where name = 'Moderate Anemia Follow-up')
  and (observations->>'0f283bcc-fa4c-4d98-93fd-cbf1729b770d')::numeric > 8 and (observations->>'0f283bcc-fa4c-4d98-93fd-cbf1729b770d')::numeric < 11
  and observations->>'d304f306-deca-4418-a9a5-27b04e083623' = '["830319d4-b616-4253-88ff-00ada2b3ff03"]' ;

