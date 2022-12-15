/* Author(s)

*/
-- indicate which database to use
-- 8/26
-- use RDB;

-- 8/31
use threetables;

/* a)
Show the number of employees in the emp_work_dept relation 
where the returned column name is numEmployees.
*/

-- 8/26
-- select count(distinct eid) as numEmployees
-- from emp_work_dept;
 
-- 8/31
select count(*) as numEmployees 
from emp;


/*
b)	List department id, department name of each department that has a manager. 
Do not list the same department id more than one time.
*/

-- 8/26
-- select did, dname
-- from emp_work_dept
-- where managerid is not null;

-- 8/31


/*
c)	List names and salaries of employees who earn more than two million dollars in ascending order of their salary. 
Do not list the same employee more than one time. Note that names are not unique. 
*/
-- 8/26
-- select ename, salary
-- from( 
-- select distinct ename,salary
-- from  emp_work_dept
-- where salary > 2000000) as rich
-- order by salary asc;

-- 8/31

/*
d)	Print all the department information (did, dname, budget, managerid) about the Accounting department and Production department. Do not list the same department more than one time. 
Query Result: The order of the rows does not matter for this query.

*/

-- 8/26
-- select distinct did, dname, budget, managerid
-- from emp_work_Dept 
-- where dname = 'Accounting' or dname='Production';

-- 8/31
select did, dname, budget, managerid
from dept
where dname = 'Accounting' or dname ='Production';

/*
e)	Print the name and salary of each employee who works in the Accounting department. 
Do not list the same employee more than one time.
*/

-- 8/26
-- select ename, salary
-- from emp_work_dept
-- where dname = 'Accounting';

-- 8/31
select e.ename, e.salary
from emp e, works w, dept d
where w.eid = e.eid and w.did = d.did and d.dname = 'Accounting';

select e.ename, e.salary
from emp e inner join works w on e.eid = w.eid
inner join dept d on w.did = d.did
where d.dname = 'Accounting';

select e.ename, e.salary
from emp e join works w on e.eid = w.eid
where w.did in
(select d.did
from dept d
where d.dname = 'Accounting');

select e.ename, e.salary
from emp e join works w on e.eid = w.eid
where exists
(select d.did
from dept d
where d.dname = 'Accounting' and d.did = w.did);

/*
f)	Print the id of each employee who works in both the Production department 
    and the Maintenance department. 
    Do not list the same employee id more than one time.
*/
-- 8/26
-- select distinct eid
-- from emp_work_dept e1 , emp_work_dept e2
-- Select from every part? finish later
-- where dname = 'Maintenance' and dname = 'Production';

-- 8/31