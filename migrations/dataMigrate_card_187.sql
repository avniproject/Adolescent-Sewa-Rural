
-- Script to migrate data from 'અમલઝર માધ્યમિક' to 'Amalzar Secondary'

select *
from address_level where title='અમલઝર માધ્યમિક';
-- 129221
select *
from address_level where title='Amalzar Secondary';
-- 130975

set role adsr;
update individual
set address_id = 130975,
    last_modified_by_id = (select * from users where username = 'taqi@adsr'),
    last_modified_date_time = current_timestamp + interval '1 millisecond'
where address_id = 129221;------16

update program_enrolment
set address_id = 130975,
    last_modified_by_id = (select * from users where username = 'taqi@adsr'),
    last_modified_date_time = current_timestamp + interval '1 millisecond'
where address_id = 129221;--16

update program_encounter
set address_id = 130975,
    last_modified_by_id = (select * from users where username = 'taqi@adsr'),
    last_modified_date_time = current_timestamp + interval '1 millisecond'
where address_id = 129221;----39







-- Script to migrate data from 'Dharoli Secondary' to'ધારોલી માધ્યમિક' ;
select *
from address_level where title='Dharoli Secondary';
-- 130986

select *
from address_level where title='ધારોલી માધ્યમિક';
-- 129240

set role adsr;
update individual
set address_id = 129240,
    last_modified_by_id = (select * from users where username = 'taqi@adsr'),
    last_modified_date_time = current_timestamp + interval '1 millisecond'
where address_id = 130986;--26

update program_enrolment
set address_id = 129240,
    last_modified_by_id = (select * from users where username = 'taqi@adsr'),
    last_modified_date_time = current_timestamp + interval '1 millisecond'
where address_id = 130986;---26

update program_encounter
set address_id = 129240,
    last_modified_by_id = (select * from users where username = 'taqi@adsr'),
    last_modified_date_time = current_timestamp + interval '1 millisecond'
where address_id = 130986;--56






-- Script to migrate data from   'રાણીપુરા, કેજીબીવી'  to 'Ranipura Girls KGBV' ;

select *
from address_level where title='રાણીપુરા, કેજીબીવી';
-- 129220
select *
from address_level where title='Ranipura Girls KGBV';
-- 130988

set role adsr;
update individual
set address_id = 130988,
    last_modified_by_id = (select * from users where username = 'taqi@adsr'),
    last_modified_date_time = current_timestamp + interval '1 millisecond'
where address_id = 129220;--11

update program_enrolment
set address_id = 130988,
    last_modified_by_id = (select * from users where username = 'taqi@adsr'),
    last_modified_date_time = current_timestamp + interval '1 millisecond'
where address_id = 129220;--10

update program_encounter
set address_id = 130988,
    last_modified_by_id = (select * from users where username = 'taqi@adsr'),
    last_modified_date_time = current_timestamp + interval '1 millisecond'
where address_id = 129220;--20



