-- Create Department Table
CREATE TABLE Department (
 DepartmentID INT PRIMARY KEY,
 DepartmentName VARCHAR(100) NOT NULL UNIQUE
);
-- Create Designation Table
CREATE TABLE Designation (
 DesignationID INT PRIMARY KEY,
 DesignationName VARCHAR(100) NOT NULL UNIQUE
);
-- Create Person Table
CREATE TABLE Person (
 PersonID INT PRIMARY KEY IDENTITY(101,1),
 FirstName VARCHAR(100) NOT NULL,
 LastName VARCHAR(100) NOT NULL,
 Salary DECIMAL(8, 2) NOT NULL,
 JoiningDate DATETIME NOT NULL,
 DepartmentID INT NULL,
 DesignationID INT NULL,
 FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID),
 FOREIGN KEY (DesignationID) REFERENCES Designation(DesignationID)
);

--Procedure Creation
CREATE OR ALTER PROCEDURE PR_Department_INSERT
	@DepartmentID INT,
	@DepartmentName Varchar(100)
As
BEGIN
	INSERT INTO Department
	(
	DepartmentID,
	DepartmentName
	)
VALUES
	(@DepartmentID,
	@DepartmentName
	)
END

EXEC PR_Department_INSERT 1,'ADMIN'
EXEC PR_Department_INSERT 2,'IT'
EXEC PR_Department_INSERT 3,'HR'
EXEC PR_Department_INSERT 4,'ACCOUNT'


CREATE OR ALTER PROCEDURE PR_Designation_INSERT
	@DesignationID INT,
	@DesignationName Varchar(100)
As
BEGIN
	INSERT INTO Designation
	(
	DesignationID,
	DesignationName
	)
VALUES
	(@DesignationID,
	@DesignationName
	)
END


EXEC PR_Designation_INSERT 11,'Jober'
EXEC PR_Designation_INSERT 12,'Welder'
EXEC PR_Designation_INSERT 13,'Clerk'
EXEC PR_Designation_INSERT 14,'Manager'
EXEC PR_Designation_INSERT 15,'CEO'


CREATE OR ALTER PROCEDURE PR_PERSON_INSERT
	@FirstName VARCHAR(100),
	@LastName VARCHAR(100),
	@Salary DECIMAL(8,2),
	@JoiningDate DATETIME,
	@DepartmentID INT,
	@DesignationID INT
AS
BEGIN
	INSERT INTO Person
	(
	FirstName,
	LastName,
	Salary,
	JoiningDate,
	DepartmentID,
	DesignationID
	)
VALUES
	(
	@FirstName,
	@LastName,
	@Salary,
	@JoiningDate,
	@DepartmentID,
	@DesignationID
	)
END


EXEC PR_PERSON_INSERT 'Rahul','Anshu',56000,'1990-01-01',1,12
EXEC PR_PERSON_INSERT 'Hardik','Hinsu',18000, '1990-09-25',2,11
EXEC PR_PERSON_INSERT 'Bhavin','Kamani',25000,'1991-05-14',NULL,11
EXEC PR_PERSON_INSERT 'Bhoomi','Patel' ,39000, '2014-02-20',1,13 
EXEC PR_PERSON_INSERT  'Rohit', 'Rajgor',17000, '1990-07-23',2,15 
EXEC PR_PERSON_INSERT 'Priya', 'Mehta',25000, '1990-10-18' ,2,NULL 
EXEC PR_PERSON_INSERT 'Neha', 'Trivedi',18000,'2014-02-20',3,15

SELECT *FROM Department
SELECT *FROM Designation
SELECT *FROM Person

--UPDATE AND DELETE LEFT 

--Department, Designation & Person Table’s SELECTBYPRIMARYKEY
CREATE OR ALTER PROC PR_PERSON_SelectByPrimaryKey
	@PERSONID INT
AS
BEGIN
	SELECT * FROM Person 
	WHERE PersonID =@PERSONID
END

EXEC PR_PERSON_SelectByPrimaryKey 102
--DEPARTMENT SelectByPrimaryKey
CREATE OR ALTER PROC PR_DEPARTMENT_SelectByPrimaryKey
	@DEPARTMENTID INT
AS
BEGIN
	SELECT *FROM Department
	WHERE DepartmentID=@DEPARTMENTID
END

EXEC PR_DEPARTMENT_SelectByPrimaryKey 2

--DESIGNATION SelectByPrimaryKey
CREATE OR ALTER PROC PR_DESIGNATION_SelectByPrimaryKey
	@DESIGNATIONID INT
AS
BEGIN
	SELECT *FROM Designation
	WHERE DesignationID=@DESIGNATIONID
END

exec PR_DESIGNATION_SelectByPrimaryKey 13

--Department, Designation & Person Table’s (If foreign key is available then do write join and take 
--columns on select list) 

--PERSON SELECTALL
CREATE OR ALTER PROC PR_PERSON_SELECTALL
AS
BEGIN 
	SELECT PersonID,FirstName,LastName,Salary,JoiningDate,Department.DepartmentName,DESIGNATION.DesignationName  FROM Person
	JOIN Department ON PERSON.DepartmentID=Department.DepartmentID
	JOIN Designation ON Person.DesignationID=Designation.DesignationID
END 

EXEC PR_PERSON_SELECTALL
 
 --DEPARTMENT SELECTALL

 CREATE OR ALTER PROC PR_DEPARTMENT_SELCETALL
 AS
 BEGIN 
	SELECT * FROM Department
END

EXEC PR_DEPARTMENT_SELCETALL

CREATE OR ALTER PROC PR_DESIGNATION_SELECTALL
AS 
BEGIN 
	SELECT * FROM Designation
END 

EXEC PR_DESIGNATION_SELECTALL
 --Create a Procedure that shows details of the first 3 persons. 
CREATE OR ALTER PROC PR_PERSON_SELECTTOP3
AS
BEGIN
	SELECT TOP 3 * FROM Person
END 

EXEC PR_PERSON_SELECTTOP3


--Part – B 
--5. Create a Procedure that takes the department name as input and returns a table with all workers working in that department.
CREATE OR ALTER PROC PR_DEPARTMENT_DepName
	@DEPARTMENTNAME VARCHAR(100)
AS 
BEGIN
	SELECT FIRSTNAME,LastName,Salary,JoiningDate,Person.DepartmentID,Person.DesignationID,DEPARTMENTNAME FROM Person JOIN Department
	ON PERSON.DepartmentID=Department.DepartmentID
	WHERE DepartmentName=@DEPARTMENTNAME
END 

EXEC PR_DEPARTMENT_DepName 'IT'
--6. Create Procedure that takes department name & designation name as input and returns a table with  worker’s first name, salary, joining date & department name.

--7. Create a Procedure that takes the first name as an input parameter and display all the details of the 
--worker with their department & designation name. 
--8. Create Procedure which displays department wise maximum, minimum & total salaries. 
--9. Create Procedure which displays designation wise average & total salaries.
