-- Author Wallapak Tavanapong
drop database if exists RDB;
create database RDB;
use RDB;
-- drop table if exists emp_work_dept;
create table emp_work_dept 
(eid int,
 ename varchar(50) not null,
 salary decimal(10,0),
 did int,
 dname varchar(40) not null, 
 budget decimal(10,0),
 managerid int, 
 pct_time int(11) DEFAULT 10,
 primary key (eid,did));
 
 -- Have to do add this after the table is created 
 -- since DBMS does not allow referencing a table that does not exist
 -- and after loading all the data
 /*
 alter table emp_work_dept add foreign key (managerid) references emp_work_dept(eid);
 */