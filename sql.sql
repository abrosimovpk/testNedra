--2.1)
create table department(id number, name varchar2(100));

create table employee(id number, department_id number, chief_id number, name varchar2(100), salary number);
insert into department values(1, 'sadasd');

insert into employee values(1, 1, 1, '1', 10000);
insert into employee values(2, 1, 1, '2', 20000);
insert into employee values(3, 1, 1, '3', 1000);



SELECT e.name
FROM employee as e
where e.chief_id in (
    Select c.id
    From employee as c
    Where c.id = e.chief_id and e.salary > c.salary
);


SELECT e.name
FROM employee as e
join employee as c on c.id = e.chief_id
Where e.salary > c.salary;

--2.2)
--2.	Вывести список сотрудников, получающих максимальную заработную плату в своем отделе.
Select name, Max(salary)
From employee
Group by department_id;

--3.	Вывести список ID отделов, количество сотрудников в которых не превышает 3 человек.
Select department_id
From employee
Group by department_id
Having count(id) < 3;

--4.	Вывести список сотрудников, не имеющих назначенного руководителя, работающего в том же отделе.

SELECT e.name
FROM employee as e
left join employee as c on c.id = e.chief_id and e.department_id <> c.department_id
where c.id is not null


--5.	Найти список ID отделов с максимальной суммарной зарплатой сотрудников.

--если хотим просто посмотреть зп всех людей в каждом отделе:
Select department.name, sum(employee.salary)
From employee
inner join department on department.id = employee.department_id
Group by employee.department_id;

--если хотим найти самые "дорогие" департаменты


Select name, max(department_salary)
from (
	Select department.name as name, sum(employee.salary) as department_salary
	From employee
	inner join department on department.id = employee.department_id
	Group by employee.department_id
)X;