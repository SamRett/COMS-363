/* Author: Samuel Rettig

//Filled out in class 8/26/22

*/
-- indicate which database to use
use RDB;

/* a)
Show the number of employees in the emp_work_dept relation 
where the returned column name is numEmployees.
*/

select count(distinct eid) as numEmployees 
from emp_work_dept;

/*
b)	List department id, department name of each department that has a manager. 
Do not list the same department id more than one time.
*/
select distinct did, dname
from emp_work_dept
where managerid is not null;

/*
c)	List names and salaries of employees who earn more than two million dollars 
in ascending order of their salary. 
Do not list the same employee more than one time. Note that names are not unique. 
*/
select ename, salary 
from
(select distinct eid, ename, salary
from emp_work_dept
where salary > 2000000) as rich
order by salary asc ;

/*
d)	Print all the department information (did, dname, budget, managerid) 
about two departments, Accounting and Production. 
Do not list the same department more than one time. 
Query Result: The order of the rows does not matter for this query.
*/

select distinct did, dname, budget, managerid
from emp_work_dept 
where dname='Accounting' or dname='Production';

/*
e)	Print the name and salary of each employee who works in the Accounting department. 
Do not list the same employee more than one time.
*/
select ename, salary
from emp_work_dept
where dname='Accounting';

/*
f)	Print the id of each employee who works in both the Production department 
    and the Maintenance department. 
    Do not list the same employee id more than one time.
    -- make each row wider so that each each row has two dname attributes
    -- match on the foreign key of the referencing relation and the primary key of the referenced relation
    -- make sure that the eid is the same 
*/
select e1.eid
from emp_work_dept e1, emp_work_dept e2
where e1.dname='Production' and e2.dname='Maintenance'
and e1.eid = e2.eid