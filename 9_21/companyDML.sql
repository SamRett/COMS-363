/*
  Authors: Teaching staff COMS 363
  Fall 2022
*/
-- part of the data are from https://github.com/Jinglin-LI/SQL-Query/blob/master/create-company-data-for-MySQL.sql
USE company;
-- The command below does not enforce checking of foreign keys.
SET FOREIGN_KEY_CHECKS=0;
-- Empty the Departments table
truncate Departments;
-- Insert five rows into the Departments table.
-- Note that while reserve terms such as INSERT INTO VALUES are case insensitive, but the 
-- data you put such as 'Research' is case-senstive
INSERT INTO Departments (dno, dname, mgrssn, startdate) VALUES (5,'Research','333-44-5555',null);
INSERT INTO Departments VALUES (4,'Administration','987-65-4321','2020-04-17');
INSERT INTO Departments VALUES (1,'Headquarters','888-66-5555','2019-04-17');
INSERT INTO Departments VALUES (6,'Software','111-11-1100','2018-04-17');
INSERT INTO Departments VALUES (7,'Hardware','444-44-4400','2017-04-17');
INSERT INTO Departments VALUES (8,'Sales','555-55-5500','2016-04-17');

-- empty the Employees table
truncate Employees;
-- insert many rows into the Employees table.
INSERT INTO Employees VALUES ('666-66-6600','Bob','B','Bender','1968-04-17','8794 Garfield, Chicago, IL','M',96000.00,NULL,NULL,8);
INSERT INTO Employees VALUES ('333-33-3300','Kim','C','Grace','1970-10-23','6677 Mills Ave, Sacramento, CA','F',79000.00,NULL,NULL,6); 
INSERT INTO Employees VALUES ('888-66-5555','James','E','Borg','1927-11-10','450 Stone, Houston, TX','M',55000.00,NULL,NULL,1); 
INSERT INTO Employees VALUES ('444-44-4400','Alex','D','Freed','1950-10-09','4333 Pillsbury, Milwaukee, WI','M',89000.00,NULL,NULL,7); 
INSERT INTO Employees VALUES ('222-22-2200','Evan','E','Wallis','1958-01-16','134 Pelham, Milwaukee, WI','M',92000.00,NULL,NULL,7); 
INSERT INTO Employees VALUES ('111-11-1100','Jared','D','James','1966-10-10','123 Peachtree, Atlanta, GA','M',85000.00,NULL,NULL,6); 
INSERT INTO Employees VALUES ('555-55-5500','John','C','James','1975-06-30','7676 Bloomington, Sacramento, CA','M',81000.00,NULL,NULL,6); 
INSERT INTO Employees VALUES ('222-22-2202','Andy','C','Vile','1944-06-21','1967 Jordan, Milwaukee, WI','M',53000.00,'222-22-2200',NULL,7); 
INSERT INTO Employees VALUES ('111-11-1103','Brad','C','Knight','1968-02-13','176 Main St., Atlanta, GA','M',44000.00,'111-11-1100',NULL,6); 
INSERT INTO Employees VALUES ('222-22-2201','Josh','U','Zell','1954-05-22','266 McGrady, Milwaukee, WI','M',56000.00,'222-22-2200',NULL,7); 
INSERT INTO Employees VALUES ('111-11-1102','Justin','n','Mark','1966-01-12','2342 May, Atlanta, GA','M',40000.00,'111-11-1100',NULL,6); 
INSERT INTO Employees VALUES ('111-11-1101','Jon','C','Jones','1967-11-14','111 Allgood, Atlanta, GA','M',45000.00,'111-11-1100',NULL,6); 
INSERT INTO Employees VALUES ('987-98-7987','Ahmad','V','Jabbar','1959-03-29','980 Dallas, Houston, TX','M',25000.00,'987-65-4321',NULL,4); 
INSERT INTO Employees VALUES ('453-45-3453','Joyce','A','English','1962-07-31','5631 Rice, Houston, TX','F',25000.00,'333-44-5555',NULL,5); 
INSERT INTO Employees VALUES ('666-88-4444','Ramesh','K','Narayan','1952-09-15','971 Fire Oak, Humble, TX','M',38000.00,'333-44-5555',NULL,5); 
INSERT INTO Employees VALUES ('999-88-7777','Alicia','J','Zelaya','1958-07-19','3321 Castle, Spring, TX','F',25000.00,'987-65-4321',NULL,4); 
INSERT INTO Employees VALUES ('123-45-6789','John','B','Smith','1955-01-09','731 Fondren, Houston, TX','M',30000.00,'333-44-5555',NULL,5); 
INSERT INTO Employees VALUES ('987-65-4321','Jennifer','S','Wallace','1931-06-20','291 Berry, Bellaire, TX','F',43000.00,'888-66-5555',NULL,4); 
INSERT INTO Employees VALUES ('333-44-5555','Franklin','T','Wong','1945-12-08','638 Voss, Houston, TX','M',40000.00,'888-66-5555',NULL,5); 
INSERT INTO Employees VALUES ('222-22-2203','Tom','G','Brand','1966-12-16','112 Third St, Milwaukee, WI','M',62500.00,'222-22-2200',NULL,7); 
INSERT INTO Employees VALUES ('222-22-2204','Jenny','F','Vos','1967-11-11','263 Mayberry, Milwaukee, WI','F',61000.00,'222-22-2201',NULL,7); 
INSERT INTO Employees VALUES ('222-22-2205','Chris','A','Carter','1960-03-21','565 Jordan, Milwaukee, WI','F',43000.00,'222-22-2201',NULL,7); 
INSERT INTO Employees VALUES ('333-33-3301','Jeff','H','Chase','1970-01-07','145 Bradbury, Sacramento, CA','M',44000.00,'333-33-3300',NULL,6); 
INSERT INTO Employees VALUES ('444-44-4401','Bonnie','S','Bays','1956-06-19','111 Hollow, Milwaukee, WI','F',70000.00,'444-44-4400',NULL,7); 
INSERT INTO Employees VALUES ('444-44-4402','Alec','C','Best','1966-06-18','233 Solid, Milwaukee, WI','M',60000.00,'444-44-4400',NULL,7); 
INSERT INTO Employees VALUES ('444-44-4403','Sam','S','Snedden','1977-07-31','987 Windy St, Milwaukee, WI','M',48000.00,'444-44-4400',NULL,7); 
INSERT INTO Employees VALUES ('555-55-5501','Nandita','K','Ball','1969-04-16','222 Howard, Sacramento, CA','M',62000.00,'555-55-5500',NULL,6); 
INSERT INTO Employees VALUES ('666-66-6601','Jill','J','Jarvis','1966-01-14','6234 Lincoln, Chicago, IL','F',36000.00,'666-66-6600',NULL,8); 
INSERT INTO Employees VALUES ('666-66-6602','Kate','W','King','1966-04-16','1976 Boone Trace, Chicago, IL','F',44000.00,'666-66-6600',NULL,8); 
INSERT INTO Employees VALUES ('666-66-6603','Lyle','G','Leslie','1963-06-09','417 Hancock Ave, Chicago, IL','M',41000.00,'666-66-6601',NULL,8); 
INSERT INTO Employees VALUES ('666-66-6604','Billie','J','King','1960-01-01','556 Washington, Chicago, IL','F',38000.00,'666-66-6603',NULL,8); 
INSERT INTO Employees VALUES ('666-66-6605','Jon','A','Kramer','1964-08-22','1988 Windy Creek, Seattle, WA','M',41500.00,'666-66-6603',NULL,8); 
INSERT INTO Employees VALUES ('666-66-6606','Ray','H','King','1949-08-16','213 Delk Road, Seattle, WA','M',44500.00,'666-66-6604',NULL,8); 
INSERT INTO Employees VALUES ('666-66-6607','Gerald','D','Small','1962-05-15','122 Ball Street, Dallas, TX','M',29000.00,'666-66-6602',NULL,8); 
INSERT INTO Employees VALUES ('666-66-6608','Arnold','A','Head','1967-05-19','233 Spring St, Dallas, TX','M',33000.00,'666-66-6602',NULL,8); 
INSERT INTO Employees VALUES ('666-66-6609','Helga','C','Pataki','1969-03-11','101 Holyoke St, Dallas, TX','F',32000.00,'666-66-6602',NULL,8); 
INSERT INTO Employees VALUES ('666-66-6610','Naveen','B','Drew','1970-05-23','198 Elm St, Philadelphia, PA','M',34000.00,'666-66-6607',NULL,8); 
INSERT INTO Employees VALUES ('666-66-6611','Carl','E','Reedy','1977-06-21','213 Ball St, Philadelphia, PA','M',32000.00,'666-66-6610',NULL,8); 
INSERT INTO Employees VALUES ('666-66-6612','Sammy','G','Hall','1970-01-11','433 Main Street, Miami, FL','M',37000.00,'666-66-6611',NULL,8); 
INSERT INTO Employees VALUES ('666-66-6613','Red','A','Bacher','1980-05-21','196 Elm Street, Miami, FL','M',33500.00,'666-66-6612',NULL,8); 

-- empty the Dependents table.
truncate Dependents;
INSERT INTO Dependents VALUES ('333-44-5555','Alice','F','1976-04-05','Daughter'); 
INSERT INTO Dependents VALUES ('333-44-5555','Theodore','M','1973-10-25','Son'); 
INSERT INTO Dependents VALUES ('333-44-5555','Joy','F','1948-05-03','Spouse'); 
INSERT INTO Dependents VALUES ('987-65-4321','Abner','M','1932-02-29','Spouse'); 
INSERT INTO Dependents VALUES ('123-45-6789','Michael','M','1978-01-01','Son'); 
INSERT INTO Dependents VALUES ('123-45-6789','Alice','F','1978-12-31','Daughter'); 
-- show the use of null, but we should also enfornce date to be not null
INSERT INTO Dependents VALUES ('123-45-6789','Elizabeth','F',null,'Spouse'); -- Converted to Null as '0000-00-00' is an invalid date in SQL SERVER
INSERT INTO Dependents VALUES ('444-44-4400','Johnny','M','1997-04-04','Son'); 
INSERT INTO Dependents VALUES ('444-44-4400','Tommy','M','1999-06-07','Son'); 
INSERT INTO Dependents VALUES ('444-44-4401','Chris','M','1969-04-19','Spouse'); 
INSERT INTO Dependents VALUES ('444-44-4402','Sam','M','1964-02-14','Spouse');  
-- empty the table
truncate Locations;
INSERT INTO Locations VALUES (1,'Houston'); 
INSERT INTO Locations VALUES (2, 'Stafford'); 
INSERT INTO Locations VALUES (3, 'Bellaire'); 
INSERT INTO Locations VALUES (4, 'Sugarland'); 
INSERT INTO Locations VALUES (5, 'Atlanta'); 
INSERT INTO Locations VALUES (6, 'Sacramento'); 
INSERT INTO Locations VALUES (7, 'Milwaukee'); 
INSERT INTO Locations VALUES (8, 'Chicago'); 
INSERT INTO Locations VALUES (9, 'Dallas'); 
INSERT INTO Locations VALUES (10, 'Miami'); 
INSERT INTO Locations VALUES (11, 'Philadephia'); 
INSERT INTO Locations VALUES (12, 'Seattle'); 
-- empty the table
truncate Department_locations;
INSERT INTO Department_locations VALUES (1,1); 
INSERT INTO Department_locations VALUES (4,2); 
INSERT INTO Department_locations VALUES (5,3); 
INSERT INTO Department_locations VALUES (5,1); 
INSERT INTO Department_locations VALUES (5,4); 
INSERT INTO Department_locations VALUES (6,5); 
INSERT INTO Department_locations VALUES (6,6); 
INSERT INTO Department_locations VALUES (7,7); 
INSERT INTO Department_locations VALUES (8,8); 
INSERT INTO Department_locations VALUES (8,9); 
INSERT INTO Department_locations VALUES (8,10); 
INSERT INTO Department_locations VALUES (8,11); 
INSERT INTO Department_locations VALUES (8,12); 

truncate Projects;
INSERT INTO Projects VALUES (1,'ProductX','ISU',5); 
INSERT INTO Projects VALUES (2,'ProductY','ISU',5); 
INSERT INTO Projects VALUES (3,'ProductZ','UNI',5); 
INSERT INTO Projects VALUES (10,'Computerization','ISU',4); 
INSERT INTO Projects VALUES (20,'Reorganization','ISU',1); 
INSERT INTO Projects VALUES (30,'Newbenefits','ISU',4); 
INSERT INTO Projects VALUES (61,'OperatingSystems','UNI',6); 
INSERT INTO Projects VALUES (62,'DatabaseSystems','UNI',6); 
INSERT INTO Projects VALUES (63,'Middleware','UI',6); 
INSERT INTO Projects VALUES (91,'InkjetPrinters','UI',7); 
INSERT INTO Projects VALUES (92,'LaserPrinters','UI',7); 

truncate works_on;
INSERT INTO Works_on VALUES ('123-45-6789',1,32.5); 
INSERT INTO Works_on VALUES ('123-45-6789',2,7.5); 
INSERT INTO Works_on VALUES ('666-88-4444',3,40.0); 
INSERT INTO Works_on VALUES ('453-45-3453',1,20.0); 
INSERT INTO Works_on VALUES ('453-45-3453',2,20.0); 
INSERT INTO Works_on VALUES ('333-44-5555',2,10.0); 
INSERT INTO Works_on VALUES ('333-44-5555',3,10.0); 
INSERT INTO Works_on VALUES ('333-44-5555',10,10.0); 
INSERT INTO Works_on VALUES ('333-44-5555',20,10.0); 
INSERT INTO Works_on VALUES ('999-88-7777',30,30.0); 
INSERT INTO Works_on VALUES ('999-88-7777',10,10.0); 
INSERT INTO Works_on VALUES ('987-98-7987',10,35.0); 
INSERT INTO Works_on VALUES ('987-98-7987',30,5.0); 
INSERT INTO Works_on VALUES ('987-65-4321',30,20.0); 
INSERT INTO Works_on VALUES ('987-65-4321',20,15.0); 
INSERT INTO Works_on VALUES ('888-66-5555',20,0.0); 
INSERT INTO Works_on VALUES ('111-11-1100',61,40.0); 
INSERT INTO Works_on VALUES ('111-11-1101',61,40.0); 
INSERT INTO Works_on VALUES ('111-11-1102',61,40.0); 
INSERT INTO Works_on VALUES ('111-11-1103',61,40.0); 
INSERT INTO Works_on VALUES ('222-22-2200',62,40.0); 
INSERT INTO Works_on VALUES ('222-22-2201',62,48.0); 
INSERT INTO Works_on VALUES ('222-22-2202',62,40.0); 
INSERT INTO Works_on VALUES ('222-22-2203',62,40.0); 
INSERT INTO Works_on VALUES ('222-22-2204',62,40.0); 
INSERT INTO Works_on VALUES ('222-22-2205',62,40.0); 
INSERT INTO Works_on VALUES ('333-33-3300',63,40.0); 
INSERT INTO Works_on VALUES ('333-33-3301',63,46.0); 
INSERT INTO Works_on VALUES ('444-44-4400',91,40.0); 
INSERT INTO Works_on VALUES ('444-44-4401',91,40.0); 
INSERT INTO Works_on VALUES ('444-44-4402',91,40.0); 
INSERT INTO Works_on VALUES ('444-44-4403',91,40.0); 
INSERT INTO Works_on VALUES ('555-55-5500',92,40.0); 
INSERT INTO Works_on VALUES ('555-55-5501',92,44.0); 
INSERT INTO Works_on VALUES ('666-66-6601',91,40.0); 
INSERT INTO Works_on VALUES ('666-66-6603',91,40.0); 
INSERT INTO Works_on VALUES ('666-66-6604',91,40.0); 
INSERT INTO Works_on VALUES ('666-66-6605',92,40.0); 
INSERT INTO Works_on VALUES ('666-66-6606',91,40.0); 
INSERT INTO Works_on VALUES ('666-66-6607',61,40.0); 
INSERT INTO Works_on VALUES ('666-66-6608',62,40.0); 
INSERT INTO Works_on VALUES ('666-66-6609',63,40.0); 
INSERT INTO Works_on VALUES ('666-66-6610',61,40.0); 
INSERT INTO Works_on VALUES ('666-66-6611',61,40.0); 
INSERT INTO Works_on VALUES ('666-66-6612',61,40.0); 
INSERT INTO Works_on VALUES ('666-66-6613',61,30.0); 
INSERT INTO Works_on VALUES ('666-66-6613',62,10.0); 
-- the line below also works
INSERT INTO Works_on VALUES ('666-66-6613','63','10.0'); 

