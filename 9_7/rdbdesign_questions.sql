-- Author Wallapak Tavanapong
drop database if exists RDB_questions;
create database RDB_questions;
use RDB_questions;

-- this table we had before
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
 
/* any issues with Design 1 */
-- Can you store all the information (rows, attributes) in emp_work_dept in design1?
-- Design 1
 create table design1
(eid int,
 ename varchar(50) not null,
 salary decimal(10,0),
 did int,
 dname varchar(40) not null, 
 budget decimal(10,0),
 managerid int, 
 pct_time int(11) DEFAULT 10,
 primary key (eid));
 -- one employee can only work for one department
 
 -- Can you store all the information in emp_work_dept in design2?
 -- design 2
create table design2
(eid int,
 ename varchar(50) not null,
 salary decimal(10,0),
 did int,
 dname varchar(40) not null, 
 budget decimal(10,0),
 managerid int, 
 pct_time int(11) DEFAULT 10,
 primary key (did));
 -- department will only be able to have one employee


 -- Different ways to keep the managing relationships
 -- Does this design keep the same information for managing as in emp_work_dept?
-- keeping information about who works for which department
create table emp  
(eid int,
 ename varchar(50) not null,
 salary decimal(10,0),
 primary key (eid));
 
 create table dept 
 (did int,
  dname varchar(40) not null, 
  budget decimal(10,0),
  primary key(did));

-- keep managing relationships 
-- any problems with this design?
create table emp_manage1
(eid int,
 did int,
 primary key (eid),
 foreign key(eid) references emp(eid), 
 foreign key(did) references dept(did));
 -- one manager per dept
 
 -- or any problems with this design?
 -- what to do if a department does not have a manager
create table emp_manage2
(managerid int,
 did int,
 primary key (did), 
 foreign key(did) references dept(did),
 foreign key(managerid) references emp(eid));
 -- the department would not be listed