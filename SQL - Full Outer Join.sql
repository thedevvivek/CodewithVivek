create table emp_2020
(
emp_id int,
designation varchar(20)
);

create table emp_2021
(
emp_id int,
designation varchar(20)
)

insert into emp_2020 values (1,'Trainee'), (2,'Developer'),(3,'Senior Developer'),(4,'Manager');
insert into emp_2021 values (1,'Developer'), (2,'Developer'),(3,'Manager'),(5,'Trainee');

select * from emp_2020
select * from emp_2021

select isnull(e20.emp_id,e21.emp_id) as emp_id
,case when e20.designation != e21.designation then 'Promotion' when e21.designation is null then 'Resigned' else 'New' end as comment
from emp_2020 e20
full outer join emp_2021 e21 on e20.emp_id = e21.emp_id
where isnull(e20.designation,'xxx') != isnull(e21.designation,'yyy')



