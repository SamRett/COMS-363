drop database if exists q2;
create database if not exists q2;

use q2;
# -1 for not dropping tables
drop table if exists MakeProducts; 
drop table if exists Products;   
drop table if exists ProductType; 
drop table if exists Ingredients; 
drop table if exists Suppliers; 
drop table if exists Bought_from; 
drop table if exists Customers; 
drop table if exists Purchase; 
drop table if exists Hourly_Workers; 
drop table if exists FullTime_Workers; 
drop table if exists Managers; 
drop table if exists Employees; 

-- For the ISA hierarchy, students may have one table with all the attributes and has a additional attribute type that indicates the type of employee. 
#1 pt for the table 
-- -0.5 pt for missing attributes 
-- -0.5 pt for missing primary key 
-- No deduction whether not null is put or not on the primary key attribute 
CREATE TABLE ProductType (            
TypeName varchar(80), 
PRIMARY KEY (TypeName)); 

#3 pts for the table 
-- -1 pt for not setting TypeName not null 
-- -0.5 pt for missing attributes 
-- -0.5 pt for missing primary key 
-- -1 pt for missing foreign key 

CREATE TABLE Products  (            
ProductID int, 
Price int, 
RemainingQTY int, 
Name varchar(80), 
TypeName varchar(80) not null, 
PRIMARY KEY (ProductID), 
FOREIGN KEY (TypeName) REFERENCES ProductType(TypeName) on delete cascade); 

#1 points for the table 
-- -0.5 pt for not missing attributes 
-- -0.5 pt for missing primary key 
CREATE TABLE Ingredients  (            
IngredientID  int, 
description varchar(80), 
PRIMARY KEY (IngredientID)); 

#1 pts for the table 
-- -0.5 pt for missing attributes 
-- -0.5 pt for missing primary key 
CREATE TABLE Suppliers  (            
SupplierName varchar(80), 
address varchar(80), 
PRIMARY KEY (SupplierName)); 

#5 points for the table 
-- -0.5 pt for missing attributes 
-- -1.5 pt for missing 3 primary key (0.5 pt for each foreign key) 
-- -3 pt for missing 3 foreign keys (1 pt for each foreign key) 
CREATE TABLE Bought_from  (            
QTY int, 
price int, 
DateOfPurchase date, 
ProductID int, 
IngredientID int, 
SupplierName varchar(80), 
PRIMARY KEY(ProductID,IngredientID,SupplierName), 
FOREIGN KEY (ProductID) REFERENCES Products(ProductID), 
FOREIGN KEY (IngredientID) REFERENCES Ingredients(IngredientID), 
FOREIGN KEY (SupplierName) REFERENCES Suppliers(SupplierName) ); 

#1 points for the table 
-- -0.5 pt for missing attributes 
-- -0.5 pt for missing primary key 
CREATE TABLE Customers  (            
CustID int, 
FirstName varchar(80), 
LastName varchar(80), 
address varchar(80), 
phone varchar(80), 
PRIMARY KEY (CustID)); 

 
#3.5 pts for the table 
-- -0.5 pt for missing attributes 
-- -1 pt for missing 2 primary key (0.5 pt for each foreign key) 
-- -2 pt for missing 2 foreign keys (1 pt for each foreign key) 
CREATE TABLE Purchase( 
ProductID int, 
CustID int, 
QTY int, 
PRIMARY KEY(ProductID, CustID), 
FOREIGN KEY (ProductID) REFERENCES Products(ProductID), 
FOREIGN KEY (CustID) REFERENCES Customers(CustID));  

#3 pts for the table 
-- -0.5 pt for missing attributes 
-- -0.5 pt for primary key 
-- -1 pt for a correct foreign key to Managers (the foregin key is added in the end of the sql) 
-- -1 pt if having not null on ManagersID 
CREATE TABLE Employees( 
EmployeeID int, 
FirstName varchar(80), 
LastName varchar(80), 
address varchar(80), 
phone varchar(80), 
ManagersID int, 
PRIMARY KEY(EmployeeID)); 

 
#2 points for the table 
-- -0.5 pt for missing attributes 
-- -0.5 pt for missing primary key 
-- -1 pt for missing foreign key 
-- No point deduction for on delete cascade 
CREATE TABLE Hourly_Workers( 
EmployeeID int, 
HoursPerWeek int, 
Specialty varchar(80), 
HourlyWage int, 
PRIMARY KEY(EmployeeID), 
FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID) on delete cascade); 

#3.5 points for the table 
-- -0.5 pt for missing attributes 
-- -1 pt for missing primary key (0.5 pt for each foreign key) 
-- -2 pt for missing 2 foreign keys (1 pt for each foreign key) 
CREATE TABLE MakeProducts( 
ProductID int, 
EmployeeID int, 
Primary key(ProductID, EmployeeID), 
FOREIGN KEY (ProductID) REFERENCES Products(ProductID), 
FOREIGN KEY (EmployeeID) REFERENCES Hourly_Workers(EmployeeID)); 

#2 pts for the table 
-- -0.5 pt for missing attributes 
-- -0.5 pt for missing primary key 
-- -1 pt for missing foreign key 
-- No point deduction for on delete cascade 
CREATE TABLE FullTime_Workers( 
EmployeeID int, 
title varchar(80), 
salary int, 
PRIMARY KEY(EmployeeID), 
FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID) on delete cascade); 

#2 pts for the table 
-- -0.5 pt for missing attributes 
-- -0.5 pt for missing primary key 
-- -1 pt for missing foreign key 
-- No point deduction for on delete cascade 
CREATE TABLE Managers( 
EmployeeID int, 
MaxSupervisingCapacity int, 
salary int, 
PRIMARY KEY(EmployeeID),
Foreign key(EmployeeID) references Employees(EmployeeID) on delete cascade); 

-- This is foregin key to Managers table of Employees table
ALTER TABLE Employees ADD CONSTRAINT Employees_FK  FOREIGN KEY (ManagersID) REFERENCES Managers(EmployeeID);

#1 free point