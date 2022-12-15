use q2;
-- this is to allow deletion without the where clause for specific rows
SET SQL_SAFE_UPDATES = 0;
TRUNCATE Bought_from;
DELETE FROM MakeProducts; 
DELETE FROM Purchase;
DELETE FROM Ingredients;
DELETE FROM Suppliers;
DELETE FROM ProductType;
DELETE FROM Products;
DELETE FROM Customers;
Update Employees set ManagersID = null;
-- due to on delete cascade for different types of employees, other sub-classes of employees got deleted as well
DELETE FROM Employees;

-- reset it back to the default values to prevent unaccidental deletion
SET SQL_SAFE_UPDATES = 1;

INSERT INTO ProductType (TypeName)
VALUES ('a1'),
('b1'),
('c1'),
('d1');

INSERT INTO Products (ProductID, Price, RemainingQTY, Name, TypeName)
VALUES (1,10,3,'a','a1'),
(2,20,4,'b','b1'),
(3,30,7,'c','c1'),
(4,40,8,'d','d1');

INSERT INTO Ingredients (IngredientID, description)
VALUES (11,"made from USA"),
(22,"made from USA"),
(33,"made from USA"),
(44,"made from USA");

INSERT INTO Suppliers (SupplierName, address)
VALUES ('supplier A','IA'),
('supplier B','NY'),
('supplier C','CA'),
('supplier D','MO'); 

INSERT INTO Bought_from (QTY, price, DateOfPurchase, ProductID, IngredientID, SupplierName)
VALUES (1000,100000,'2008-11-11',1,11,'supplier A'),
(2000,200000,'2008-11-12',2,44,'supplier A'),
(3000,300000,'2008-11-13',2,22,'supplier B'),
(4000,400000,'2008-11-14',3,33,'supplier C');

INSERT INTO Customers (CustID, FirstName, LastName, address, phone)
VALUES (1,'Tess','Nguyen','IA','1111111111'),
(2,'Tom','Nolan','NY','2222222222'),
(3,'Tommy','Wan','CA','3333333333'),
(4,'Huang','Phong','MO','4444444444');

INSERT INTO Purchase (ProductID, CustID, QTY)
VALUES (1,1,10),
(1,2,22),
(2,3,33),
(2,4,44);
    
INSERT INTO Employees (EmployeeID,FirstName,LastName,address,phone,ManagersID)
VALUES 
(1,'a1','a2','IA','1111111111',null),
(2,'b1','b2','IA','1111111113',null),
(3,'c1','c2','IA','1111111114',null),
(4,'d1','d2','IA','1111111112',null),
(5,'e1','e2','IA','1111111115',null),
(6,'f1','f2','IA','1111111116',null),
(7,'g1','g2','IA','1111111117',null),
(8,'h1','h2','IA','1111111118',null),
(9,'i1','i2','IA','1111111121',null),
(10,'j1','j2','IA','1111111131',null),
(11,'k1','k2','IA','1111111141',null),
(12,'l1','l2','IA','1111111151',null);

INSERT INTO Managers (EmployeeID,MaxSupervisingCapacity,salary)
VALUES (1,10,200000),
(2,10,200000),
(5,10,180000),
(6,10,170000),
(7,10,210000);   

-- as managers are also employees; we need to do the updates later
update Employees set ManagersID = 2 where EmployeeID = 1;
update Employees set ManagersID = 1 where EmployeeID = 2;
update Employees set ManagersID = 1 where EmployeeID = 3;
update Employees set ManagersID = 1 where EmployeeID = 4;
update Employees set ManagersID = 1 where EmployeeID = 5;
update Employees set ManagersID = 1 where EmployeeID = 6;
update Employees set ManagersID = 1 where EmployeeID = 7;
update Employees set ManagersID = 5 where EmployeeID = 8;
update Employees set ManagersID = 6 where EmployeeID = 9;
update Employees set ManagersID = 7 where EmployeeID = 10;
update Employees set ManagersID = 1 where EmployeeID = 11;
update Employees set ManagersID = 1 where EmployeeID = 12;

INSERT INTO Hourly_Workers (EmployeeID,HoursPerWeek,Specialty,HourlyWage)
VALUES (1,20,'x',13),
(2,20,'y',16),
(3,20,'z',14),
(4,20,'m',15);

INSERT INTO MakeProducts (ProductID,EmployeeID)
VALUES (1,1),
(1,2),
(2,3),
(2,4);

INSERT INTO FullTime_Workers (EmployeeID,title,salary)
VALUES (5,'A1',100000),
(6,'B1',80000),
(7,'C1',70000),
(8,'D1',110000);

