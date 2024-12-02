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