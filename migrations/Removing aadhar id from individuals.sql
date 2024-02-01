set role adsr;

UPDATE individual 
SET observations = observations #- '{736d7a2e-438e-4248-8e77-021f9ce8a20b}',
last_modified_date_time = current_timestamp + ((id % 4000) * interval '1 millisecond'),
last_modified_by_id = (select id from users where username = 'taqi@adsr'),
manual_update_history = manual_update_history || ' #3435, Removing aadhar id observation from individuals';
