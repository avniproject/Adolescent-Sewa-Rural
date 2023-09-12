set role adsr;

select * from address_level al where title = 'Jaamboi'; -- 129206

select * from address_level al where title = 'Jamboi'; -- 408549

select count(*) from individual i where address_id = 129206; -- 40

select count(*) from individual i where address_id = 408549; -- 3

select * from users where username = 'taqi@adsr' ; -- 5327

update individual 
set address_id = 129206,
last_modified_date_time = current_timestamp + interval '1 millisecond',
last_modified_by_id = 5327
where address_id = 408549;

update program_encounter  
set address_id = 129206,
last_modified_date_time = current_timestamp + interval '1 millisecond',
last_modified_by_id = 5327
where address_id = 408549;

update program_enrolment  
set address_id = 129206,
last_modified_date_time = current_timestamp + interval '1 millisecond',
last_modified_by_id = 5327
where address_id = 408549;

update address_level 
set is_voided = true,
last_modified_date_time = current_timestamp + interval '1 millisecond',
last_modified_by_id = 5327
where address_id = 408549;
