CREATE TABLE Departments ( 
DepartmentID INT PRIMARY KEY, 
DepartmentName VARCHAR(100) NOT NULL UNIQUE, 
ManagerID INT NOT NULL, 
Location VARCHAR(100) NOT NULL 
); 
CREATE TABLE Employee ( 
EmployeeID INT PRIMARY KEY, 
FirstName VARCHAR(100) NOT NULL, 
LastName VARCHAR(100) NOT NULL, 
DoB DATETIME NOT NULL, 
Gender VARCHAR(50) NOT NULL, 
HireDate DATETIME NOT NULL, 
DepartmentID INT NOT NULL, 
Salary DECIMAL(10, 2) NOT NULL, 
FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID) 
); -- Create Projects Table 
CREATE TABLE Projects ( 
ProjectID INT PRIMARY KEY, 
ProjectName VARCHAR(100) NOT NULL, 
StartDate DATETIME NOT NULL, 
EndDate DATETIME NOT NULL, 
DepartmentID INT NOT NULL, 
FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID) 
); 
INSERT INTO Departments (DepartmentID, DepartmentName, ManagerID, Location) 
VALUES  
(1, 'IT', 101, 'New York'), 
(2, 'HR', 102, 'San Francisco'), 
(3, 'Finance', 103, 'Los Angeles'), 
(4, 'Admin', 104, 'Chicago'), 
(5, 'Marketing', 105, 'Miami'); 
INSERT INTO Employee (EmployeeID, FirstName, LastName, DoB, Gender, HireDate, DepartmentID, 
Salary) 
VALUES  
(101, 'John', 'Doe', '1985-04-12', 'Male', '2010-06-15', 1, 75000.00), 
(102, 'Jane', 'Smith', '1990-08-24', 'Female', '2015-03-10', 2, 60000.00), 
(103, 'Robert', 'Brown', '1982-12-05', 'Male', '2008-09-25', 3, 82000.00), 
(104, 'Emily', 'Davis', '1988-11-11', 'Female', '2012-07-18', 4, 58000.00), 
(105, 'Michael', 'Wilson', '1992-02-02', 'Male', '2018-11-30', 5, 67000.00); 
INSERT INTO Projects (ProjectID, ProjectName, StartDate, EndDate, DepartmentID) 
VALUES  
(201, 'Project Alpha', '2022-01-01', '2022-12-31', 1), 
(202, 'Project Beta', '2023-03-15', '2024-03-14', 2), 
(203, 'Project Gamma', '2021-06-01', '2022-05-31', 3), 
(204, 'Project Delta', '2020-10-10', '2021-10-09', 4), 
(205, 'Project Epsilon', '2024-04-01', '2025-03-31', 5);


--Part � A 
--1. Create Stored Procedure for Employee table As User enters either First Name or Last Name and based 
--on this you must give EmployeeID, DOB, Gender & Hiredate.  
CREATE OR ALTER PROC PR_EMPLOYEE_EITHERFIRSTORLAST
	@FIRSTNAME VARCHAR(100) = NULL,
	@LASTNAME VARCHAR(100) = NULL 
AS 
BEGIN
	SELECT EmployeeID,DOB,GENDER,HIREDATE FROM Employee
	WHERE (FirstName=@FIRSTNAME)
	OR (LastName=@LASTNAME)
END

EXEC PR_EMPLOYEE_EITHERFIRSTORLAST @LASTNAME ='DOE'

--2. Create a Procedure that will accept Department Name and based on that gives employees list who 
--belongs to that department. 
CREATE OR ALTER PROCEDURE PR_EMPLOYEE_BY_DEPARTMENT
    @DepartmentName VARCHAR(100)
AS
BEGIN
   
    SELECT
        Employee.EmployeeID,
        Employee.FirstName,
        Employee.LastName,
        Employee.DoB,
        Employee.Gender,
        Employee.HireDate,
        Department.DepartmentName
    FROM
        Employee
    JOIN
        Department ON Employee.DepartmentID = Department.DepartmentID
    WHERE
        Department.DepartmentName = @DepartmentName;
END
EXEC PR_EMPLOYEE_BY_DEPARTMENT @DepartmentName = 'IT';

--3. Create a Procedure that accepts Project Name & Department Name and based on that you must give
--all the project related details.
CREATE OR ALTER PROCEDURE PR_PROJECT_BY_NAME_AND_DEPARTMENT
    @ProjectName VARCHAR(100),
    @DepartmentName VARCHAR(100)
AS
BEGIN
    -- Select project details based on Project Name and Department Name
    SELECT
        Project.ProjectID,
        Project.ProjectName,
        Project.StartDate,
        Project.EndDate,
        Department.DepartmentName
    FROM
        Projects Project
    JOIN
        Department ON Project.DepartmentID = Department.DepartmentID
    WHERE
        Project.ProjectName = @ProjectName
        AND Department.DepartmentName = @DepartmentName;
END
EXEC PR_PROJECT_BY_NAME_AND_DEPARTMENT @ProjectName = 'Project Alpha', @DepartmentName = 'IT';


--4. Create a procedure that will accepts any integer and if salary is between provided integer, then those
--employee list comes in output.
CREATE OR ALTER PROCEDURE PR_EMPLOYEE_BY_SALARY_RANGE
    @SalaryThreshold INT
AS
BEGIN
    -- Select employees whose salary is less than or equal to the provided threshold
    SELECT
        Employee.EmployeeID,
        Employee.FirstName,
        Employee.LastName,
        Employee.Salary
    FROM
        Employee
    WHERE
        Employee.Salary <= @SalaryThreshold;
END
EXEC PR_EMPLOYEE_BY_SALARY_RANGE @SalaryThreshold = 70000;

--5. Create a Procedure that will accepts a date and gives all the employees who all are hired on that date
CREATE OR ALTER PROCEDURE PR_EMPLOYEE_BY_HIREDATE
    @HireDate DATETIME
AS
BEGIN
    -- Select employees who were hired on the specified Hire Date
    SELECT
        Employee.EmployeeID,
        Employee.FirstName,
        Employee.LastName,
        Employee.HireDate
    FROM
        Employee
    WHERE
        Employee.HireDate = @HireDate;
END
EXEC PR_EMPLOYEE_BY_HIREDATE @HireDate = '2018-11-30';