-- Author Samuel Rettig
USE store;
-- The command below does not enforce checking of foreign keys.
SET FOREIGN_KEY_CHECKS=0;

-- Empty the Products table, same for rest
truncate Products;

INSERT INTO Products VALUES (3,'Bannana',1,100, 'Fruit');
INSERT INTO Products VALUES (1,'Apple',2,150, 'Fruit');
INSERT INTO Products VALUES (5,'Pop-Tart',3,50, 'Pastry');
INSERT INTO Products VALUES (6,'Frozen Pizza',4,30, 'Frozen');

-- Customers below
truncate Customers;

INSERT INTO Customers VALUES (1,'Samuel','Rettig','Suzy Queue
4455 Landing Lange, APT 4', '319-754-3933');
INSERT INTO Customers VALUES (2,'Max','Tobuscus','SGT Miranda McAnderson
6543 N 9th Street', '319-322-2143');
INSERT INTO Customers VALUES (3,'Fred','Well','Henry Hernandez
Notting', '319-054-1243');
INSERT INTO Customers VALUES (4,'John','John','90210 Broadway Blvd.
Nashville', '319-231-4532');

-- Employees below
truncate Employees;

INSERT INTO Employees VALUES (1,'90210 Broadway Blvd.
Nashville','Jon',1,'Maxxy', '319-222-6533');
INSERT INTO Employees VALUES (2,'Cecelia Havens
456 White Finch St.','Jolie',2,'Fresh', '319-211-6839');
INSERT INTO Employees VALUES (3,'Kenner Group Inc.
85 Bradford Lane','Emily',3,'Mana', '319-121-5533');
INSERT INTO Employees VALUES (4,'PFC Isobel Jones
PSC 5 BOX 7260 APO AE','Lia',4,'Well', '319-933-4943');

-- Employees below
truncate Managers;

INSERT INTO Managers VALUES (1,2,584.5);
INSERT INTO Managers VALUES (2,8,1000.4);
INSERT INTO Managers VALUES (3,10,20.3);
INSERT INTO Managers VALUES (4,5,900000.5);

-- Full Time Workers below
truncate FullTime_Workers;

INSERT INTO FullTime_Workers VALUES (1,'loser',1000.2);
INSERT INTO FullTime_Workers VALUES (2,'loser x2',90000000.2);
INSERT INTO FullTime_Workers VALUES (3,'loser x3',193933.7);
INSERT INTO FullTime_Workers VALUES (4,'loser x4',303033.6);

-- Full Time Workers below
truncate Hourly_Workers;

INSERT INTO Hourly_Workers VALUES (1,30303.4,'nothing',58383.6);
INSERT INTO Hourly_Workers VALUES (2,1.1,'everything',58544.7);
INSERT INTO Hourly_Workers VALUES (3,40.6,'machinery',30000.7);
INSERT INTO Hourly_Workers VALUES (4,59494.7,'stocking',2000.7);

-- Makes below
truncate makes;

INSERT INTO makes VALUES (1,1);
INSERT INTO makes VALUES (1,2);
INSERT INTO makes VALUES (1,3);
INSERT INTO makes VALUES (1,4);

-- Ingredient below
truncate Ingredient;

INSERT INTO Ingredient VALUES (1,'its mushy');
INSERT INTO Ingredient VALUES (2,'bright');
INSERT INTO Ingredient VALUES (3,'hard');
INSERT INTO Ingredient VALUES (4,'tasty');

-- Suppliers below
truncate Suppliers;

INSERT INTO Suppliers VALUES ('Walmart', 'Jacob Tomlinson 75N Southern Street');
INSERT INTO Suppliers VALUES ('Target', 'Noah Tonkin 86 Baker St.');
INSERT INTO Suppliers VALUES ('Aldi', 'Jamie Bower 157 Windfall Rd.');
INSERT INTO Suppliers VALUES ('Other', 'Georgia Labonair PO BOX 523029');

-- Bought from below
truncate bought_from;

INSERT INTO bought_from VALUES (1,'1-11-2022', 2, 1, 'Walmart', 1);
INSERT INTO bought_from VALUES (2,'2-12-2022', 30, 2, 'Target', 2);
INSERT INTO bought_from VALUES (3,'8-21-2022', 60, 3, 'Aldi', 3);
INSERT INTO bought_from VALUES (4,'4-19-2022', 5, 4, 'Other', 4);

-- purchase below
truncate purchase;

INSERT INTO purchase VALUES (20,1,3);
INSERT INTO purchase VALUES (60,2,7);
INSERT INTO purchase VALUES (80,3,2);
INSERT INTO purchase VALUES (100,4,5);







