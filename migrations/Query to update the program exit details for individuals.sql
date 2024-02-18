set role adsruat;

-- Via script, marking all the program enrollments under the following locations as 'Exited'. This involves adding the program exit date (01-01-2024) and
-- exit observations as 'Reason for exit': 'Change of school out of intervention area'.

-- The program enrollments for the following schools need to be exited: 'Rajpardi Kanya Primary', 'Jhagadiya branch primary', 'Zagadiya Kumar Primary', 'Ranipura P.S.', 'Limbodara Primary'.

-- If you intend to make changes in the production environment, please modify the address level type id and last modified by id.
   

----------------------------------------------------------------------------------------------------------------------------------------------------
--Update Query

update
	public.program_enrolment as enrl
set
	program_exit_observations = enrl.program_exit_observations || jsonb_build_object('55454f19-f84e-4be4-afe8-c20a6ed6576a', '"5c74a9c0-659e-4915-b8fd-d0203da0d3a0"'),  
	last_modified_date_time = '2024-01-01'::timestamp + ((enrl.id % 1000) * interval '1 millisecond'),
	program_exit_date_time = '2024-01-01'::timestamp + ((enrl.id % 1000) * interval '1 millisecond'),
	last_modified_by_id = 10366,
	manual_update_history = enrl.manual_update_history || ', Updating the program decision concept Current Standard for old data as per #23 card'
from
	public.individual i
left join address a on
	a.id = i.address_id
left join public.address_level al on
	al.id = a."School id"
where
	i.is_voided = false
	and enrl.is_voided = false
	and i.id = enrl.individual_id
	and al.type_id = 715 -- al.type_id = 1307 for UAT
	and enrl.program_exit_date_time is null
	and al.title in ('Rajpardi Kanya Primary', 'Jhagadiya branch primary', 'Zagadiya Kumar Primary', 'Ranipura P.S.', 'Limbodara Primary');


----------------------------------------------------------------------------------------------------------------------------------------------------
--Select Query

select
	i.id,
	i.first_name,
	i.last_name,
	al.title as "School",
	enrl.id as enrl_id,
        '2024-01-01'::timestamp + ((enrl.id % 1000) * interval '1 millisecond') as time,
	enrl.program_exit_observations
from
	program_enrolment enrl
left join individual i on
	i.id = enrl.individual_id
left join address a on
	a.id = i.address_id
left join address_level al on
	al.id = a."School id"
where
	i.is_voided = false
	and enrl.is_voided = false
	and al.type_id = 715
	and enrl.program_exit_date_time is null
	and al.title in ('Rajpardi Kanya Primary', 'Jhagadiya branch primary', 'Zagadiya Kumar Primary', 'Ranipura P.S.', 'Limbodara Primary');
