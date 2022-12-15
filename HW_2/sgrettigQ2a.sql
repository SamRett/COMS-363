-- Author Samuel Rettig

DROP database if exists `store`;

CREATE DATABASE if not exists `store`;

USE store;

-- comment to seperate stuff

-- Table for Products
-- product type table is redundant, removed as well as possible
drop table if exists Products;
create table Products(
price int, 
name varchar(40) not null,
ItemID int,
remaining int,
type_name varchar(40) not null,
primary key(ItemID)
);

-- Table for Customers
drop table if exists Customers;
create table Customers(
ID int, 
first_name varchar(40) not null, 
last_name varchar(40) not null, 
address varchar(40), 
phone_no varchar(40), 
primary key (ID)
);

-- Table for Employees, total particapation of the managers is done by a trigger
drop table if exists Employees;
create table Employees(
emp_ID int, address varchar(40),
first_name varchar(40) not null, 
manager_ssn int,
last_name varchar(40) not null, 
phone_no varchar(40),
primary key (emp_ID)
);

-- Table for Full time workers
drop table if exists Managers;
create table Managers(
manager_emp_ID int,
maxSupervisingCapacity int,
salary float,
primary key(manager_emp_ID),
foreign key(manager_emp_ID) references Employees(emp_ID)
);

alter table Employees
add foreign key (manager_ssn) references Managers(manager_emp_ID);

-- Table for Full time workers
drop table if exists FullTime_Workers;
create table FullTime_Workers(
fulltime_emp_ID int,
title varchar(40),
salary float,
primary key(fulltime_emp_ID),
foreign key(fulltime_emp_ID) references Employees(emp_ID)
);

drop table if exists Hourly_Workers;
create table Hourly_Workers(
hourly_emp_ID int,
hours_per_week float,
specialty varchar(40),
hourly_wage float,
primary key(hourly_emp_ID),
foreign key(hourly_emp_ID) references Employees(emp_ID)
);

-- this relationship makes it so employees (hourly) can produce a product
drop table if exists makes;
create table makes(
Emp_id int,
item_ID int,
primary key (Emp_id, Item_id),
foreign key (Emp_id) references Employees (emp_id),
foreign key (item_ID) references Products (ItemID)
);

-- Table for Ingredient
drop table if exists Ingredient;
create table Ingredient(
item_id int,
descr varchar (40),
primary key (item_id)
);

-- Table for suppliers
drop table if exists Suppliers;
create table Suppliers(
supp_name varchar(40) not null,
address varchar(40),
primary key(supp_name)
);

-- database trigger is needed for the total participation of Products entity set in this relation set
drop table if exists bought_from;
create table bought_from(
qty int,
date_of_purchase varchar(40) not null,
price int,
itemID int, 
supplierName varchar(40),
prod_itemID int,
primary key (itemID, supplierName, prod_itemID),
foreign key (itemID) references Ingredient (item_id),
foreign key (supplierName) references Suppliers (supp_name),
foreign key (prod_itemID) references Products (ItemID)
);

-- this relationship ensures that customers can purchase correctly
drop table if exists purchase;
create table purchase(
quantity int,
Cust_ID int,
Item_id int,
primary key (Cust_id, Item_id),
foreign key (Cust_ID) references Customers (ID),
foreign key (Item_id) references Products (ItemID)
);


