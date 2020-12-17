--1.	Вывести список сотрудников, получающих заработную плату большую чем у непосредственного руководителя.
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

insert into employee values(1, 2, 1, '1', 1);
insert into employee values(2, 2, 1, '2', 2);
insert into employee values(3, 1, 1, '3', 3);
insert into employee values(4, 1, 2, '4', 40);
---result:
---------2
---------3
---------4

insert into employee values(1, 2, 1, '1', 100);
insert into employee values(2, 2, 1, '2', 2);
insert into employee values(3, 1, 1, '3', 3);
insert into employee values(4, 1, 2, '4', 400);
---result:
---------4

insert into employee values(1, 2, 1, '1', 100);
insert into employee values(2, 2, 1, '2', 2);
insert into employee values(3, 1, 1, '3', 3);
insert into employee values(4, 1, 2, '4', 1);
---result:
---------empty

--2.	Вывести список сотрудников, получающих максимальную заработную плату в своем отделе.
Select name, Max(salary)
From employee
Group by department_id;

insert into employee values(1, 2, 1, '1', 1);
insert into employee values(2, 2, 1, '2', 2);
insert into employee values(3, 1, 1, '3', 3);
insert into employee values(4, 1, 2, '4', 40);
---result:
---------4|40
---------2|2
insert into employee values(1, 1, 1, '1', 1);
insert into employee values(2, 1, 1, '2', 2);
insert into employee values(3, 1, 1, '3', 3);
insert into employee values(4, 1, 2, '4', 40);
---result:
---------4|40

--3.	Вывести список ID отделов, количество сотрудников в которых не превышает 3 человек.

Select department_id
From employee
Group by department_id
Having count(id) < 3;

insert into employee values(1, 2, 1, '1', 1);
insert into employee values(2, 1, 1, '2', 2);
insert into employee values(3, 1, 1, '3', 3);
insert into employee values(4, 1, 2, '4', 40);
---result:
---------2
insert into employee values(1, 2, 1, '1', 1);
insert into employee values(2, 2, 1, '2', 2);
insert into employee values(3, 1, 1, '3', 3);
insert into employee values(4, 1, 2, '4', 40);
---result:
---------1
---------2

--4.	Вывести список сотрудников, не имеющих назначенного руководителя, работающего в том же отделе.

SELECT e.name
FROM employee as e
left join employee as c on c.id = e.chief_id and e.department_id <> c.department_id
where c.id is not null

insert into department values(1, '1111111111');
insert into department values(2, '2222222222');

insert into employee values(1, 1, 1, '1', 1);
insert into employee values(2, 1, 1, '2', 2);
insert into employee values(3, 2, 1, '3', 3);
insert into employee values(4, 2, 2, '4', 4);
---result:
--------- empty
insert into department values(1, '1111111111');
insert into department values(2, '2222222222');

insert into employee values(1, 2, 1, '1', 1);
insert into employee values(2, 1, 1, '2', 2);
insert into employee values(3, 1, 1, '3', 3);
insert into employee values(4, 1, 2, '4', 40);
---result:
---------2
---------3



--5.	Найти список ID отделов с максимальной суммарной зарплатой сотрудников.

--если хотим просто посмотреть зп всех людей в каждом отделе:
Select department.name, sum(employee.salary)
From employee
inner join department on department.id = employee.department_id
Group by employee.department_id;

-----------------------------------------------------------------------------------------
insert into department values(1, '1111111111');
insert into department values(2, '2222222222');

insert into employee values(1, 1, 1, '1', 1);
insert into employee values(2, 1, 1, '2', 2);
insert into employee values(3, 2, 1, '3', 3);
insert into employee values(4, 2, 2, '4', 4);
---result:
---------1111111111|3
---------2222222222|7
insert into employee values(1, 1, 1, '1', 1);
insert into employee values(2, 1, 1, '2', 2);
insert into employee values(3, 1, 1, '3', 3);
insert into employee values(4, 1, 2, '4', 40);
---result:
---1111111111|46

--если хотим найти самые "дорогие" департаменты
Select name, max(department_salary)
from (
	Select department.name as name, sum(employee.salary) as department_salary
	From employee
	inner join department on department.id = employee.department_id
	Group by employee.department_id
)X;
-----------------------------------------------------------------------------------------
insert into department values(1, '1111111111');
insert into department values(2, '2222222222');

insert into employee values(1, 1, 1, '1', 1);
insert into employee values(2, 1, 1, '2', 2);
insert into employee values(3, 2, 1, '3', 3);
insert into employee values(4, 2, 2, '4', 4);
---result:
---------2222222222|7
insert into employee values(1, 1, 1, '1', 1);
insert into employee values(2, 1, 1, '2', 2);
insert into employee values(3, 1, 1, '3', 3);
insert into employee values(4, 1, 2, '4', 4);
---result:
---1111111111|10