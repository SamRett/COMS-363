-- SQL Script for Generating the Kitchen Database Modified for an exam
-- Authors: Randy Patanasakpinyo and W. Tavanapong
drop database if exists fooddb_ex;
create database fooddb_ex;
use fooddb_ex;
drop table if exists recipe; 

drop table if exists food;
create table food 
(fid int, 
fname varchar(45) not null unique,
 primary key(fid));

drop table if exists ingredient; 
create table ingredient
 (iid int, 
 iname varchar(45) unique,
 caloriepergram float,
 category varchar(20),
 primary key(iid)
 );


create table recipe (
  amount int,
  fid int,
  iid int,
  primary key(fid,iid),
  foreign key(fid) references food(fid),
  foreign key(iid) references ingredient(iid)
 );
 

INSERT INTO `food` VALUES (18,'Fried Rice'),(22,'Orange Chicken'),(25,'BBQ Pork'),(26,'BBQ Chicken'),(27,'Fried Noodle'),(30,'Mongolian Beef');

INSERT INTO `ingredient` VALUES(21,'Pork', 1.44, 'Meat'),(23,'Chicken', 1.65, 'Meat'),(24,'Orange', 0.47, 'Vegetable'),(28,'Green Onion', 0.10, 'Vegetable'),(29,'Egg Noodle', 2.0, 'Carbohydrate'),(30, 'Potato', 5, 'Veggie'),(31,'Cheese',4, 'Diary');

INSERT INTO `recipe` VALUES (250,22,23),(100,22,24),(300,25,21),(250,26,23),(200,27,23),(60,27,28),(100,27,29);

