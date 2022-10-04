set role adsr;

select * from users; -- taqi@adsr  5327

select * from address_level al where  id = 130980; --Jespor Secondary (voided~130980)

select count(*) from individual i where address_id = 130980 and is_voided is false; -- 90 individuals;

select * from address_level al where id = 129226; -- જેસપોર માધ્યમિક

select count(*) from individual i where address_id = 129226 and is_voided is false; --7 individuals;

update individual 
set address_id = 129226,
last_modified_date_time = current_timestamp + interval '1 millisecond',
last_modified_by_id = 5327
where address_id = 130980; --91

update program_encounter  
set address_id = 129226,
last_modified_date_time = current_timestamp + interval '1 millisecond',
last_modified_by_id = 5327
where address_id = 130980; --201

update program_enrolment  
set address_id = 129226,
last_modified_date_time = current_timestamp + interval '1 millisecond',
last_modified_by_id = 5327
where address_id = 130980; --91
