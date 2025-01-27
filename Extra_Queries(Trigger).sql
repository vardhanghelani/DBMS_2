CREATE TABLE EMPLOYEEDETAILS
(
	EmployeeID Int Primary Key,
	EmployeeName Varchar(100) Not Null,
	ContactNo Varchar(100) Not Null,
	Department Varchar(100) Not Null,
	Salary Decimal(10,2) Not Null,
	JoiningDate DateTime Null
)
CREATE TABLE EmployeeLogs (
    LogID INT PRIMARY KEY IDENTITY(1,1),
    EmployeeID INT NOT NULL,
    EmployeeName VARCHAR(100) NOT NULL,
    ActionPerformed VARCHAR(100) NOT NULL,
    ActionDate DATETIME NOT NULL
);

--1)	Create a trigger that fires AFTER INSERT, UPDATE, and DELETE operations on the EmployeeDetails table to display the message "Employee record inserted", "Employee record updated", "Employee record deleted"
Create Trigger Tr_insert_message
on EMPLOYEEDETAILS
after insert
as
begin
print'Record is inserted'
end

Create Trigger Tr_updated_message
on EMPLOYEEDETAILS
after update
as
begin
print'Record is updated'
end

Create Trigger Tr_deleted_message
on EMPLOYEEDETAILS
after delete
as
begin
print'Record is deleted'
end
--2)	Create a trigger that fires AFTER INSERT, UPDATE, and DELETE operations on the EmployeeDetails table to log all operations into the EmployeeLog table.
CREATE OR ALTER TRIGGER TR_INSERT_EMP_LOG
ON EMPLOYEEDETAILS
AFTER INSERT
AS
BEGIN
	DECLARE @EmployeeID INT
	DECLARE @EmployeeName VARCHAR(110)

	SELECT @EmployeeID=EmployeeID FROM inserted
	SELECT @EmployeeName=EmployeeName FROM inserted


	INSERT INTO EmployeeLogs VALUES(@EmployeeID,@EmployeeName,'INSERT',GETDATE())

END

CREATE OR ALTER TRIGGER TR_UPDATE_EMP_LOG
ON EMPLOYEEDETAILS
AFTER UPDATE
AS
BEGIN
	DECLARE @EmployeeID INT
	DECLARE @EmployeeName VARCHAR(110)

	SELECT @EmployeeID=EmployeeID FROM inserted
	SELECT @EmployeeName=EmployeeName FROM inserted


	INSERT INTO EmployeeLogs VALUES(@EmployeeID,@EmployeeName,'UPDATE',GETDATE())

END

CREATE OR ALTER TRIGGER TR_DELETE_EMP_LOG
ON EMPLOYEEDETAILS
AFTER DELETE
AS
BEGIN
	DECLARE @EmployeeID INT
	DECLARE @EmployeeName VARCHAR(110)

	SELECT @EmployeeID=EmployeeID FROM inserted
	SELECT @EmployeeName=EmployeeName FROM inserted

	 
	INSERT INTO EmployeeLogs VALUES(@EmployeeID,@EmployeeName,'DELETE',GETDATE())

END
--3)	Create a trigger that fires AFTER INSERT to automatically calculate the joining bonus (10% of the salary) for new employees and update a bonus column in the EmployeeDetails table.
CREATE TRIGGER TR_UPDATE_EMP_BONUS
ON EMPLOYEEDETAILS
AFTER INSERT
AS
BEGIN
	UPDATE EMPLOYEEDETAILS SET Salary=(Salary+0.1*Salary)
END	
--4)	Create a trigger to ensure that the JoiningDate is automatically set to the current date if it is NULL during an INSERT operation.
CREATE OR ALTER TRIGGER TR_JOINJDATE_NULL
ON EMPLOYEEDETAILS
AFTER INSERT
AS
BEGIN
	UPDATE EMPLOYEEDETAILS SET JoiningDate=GETDATE()
	FROM EMPLOYEEDETAILS JOIN inserted ON EMPLOYEEDETAILS.EmployeeID=inserted.EmployeeID
	WHERE inserted.JoiningDate IS NULL 
END

--5)	Create a trigger that ensure that ContactNo is valid during insert and update (Like ContactNo length is 10)
CREATE TRIGGER TR_CONTACT_LEN
ON EMPLOYEEDETAILS
AFTER INSERT 
AS BEGIN
DECLARE @CONTACTno VARCHAR(100)
DECLARE @EID INT

SELECT @CONTACTno= ContactNo FROM  inserted
SELECT @EID = EmployeeID FROM inserted

IF(LEN(@CONTACTno)<>10)
	BEGIN 
		PRINT'INVALID CONTACT'
		DELETE FROM EMPLOYEEDETAILS WHERE EmployeeID=@EID
	END
END


CREATE TABLE Movies (
    MovieID INT PRIMARY KEY,
    MovieTitle VARCHAR(255) NOT NULL,
    ReleaseYear INT NOT NULL,
    Genre VARCHAR(100) NOT NULL,
    Rating DECIMAL(3, 1) NOT NULL,
    Duration INT NOT NULL
);

CREATE TABLE MoviesLog
(
	LogID INT PRIMARY KEY IDENTITY(1,1),
	MovieID INT NOT NULL,
	MovieTitle VARCHAR(255) NOT NULL,
	ActionPerformed VARCHAR(100) NOT NULL,
	ActionDate	DATETIME  NOT NULL
);


--1.	Create an INSTEAD OF trigger that fires on INSERT, UPDATE and DELETE operation on the Movies table. For that, log all operations performed on the Movies table into MoviesLog.
create trigger TR_insert_instead
ON MOVIES
INSTEAD OF INSERT
AS
BEGIN
DECLARE @MOVIEID INT
DECLARE @MOVIETITLE VARCHAR(100)

SELECT @MOVIEID= MOVIEID FROM inserted
SELECT @MOVIETITLE= MOVIETITLE FROM INSERTED

INSERT INTO MoviesLog VALUES(@MOVIEID,@MOVIETITLE,'INSERT',GETDATE())
END

DROP TRIGGER TR_UPDATE_INSTEAD

create trigger TR_insert_instead
ON MOVIES
INSTEAD OF UPDATE
AS
BEGIN
DECLARE @MOVIEID INT
DECLARE @MOVIETITLE VARCHAR(100)

SELECT @MOVIEID= MOVIEID FROM inserted
SELECT @MOVIETITLE= MOVIETITLE FROM INSERTED

INSERT INTO MoviesLog VALUES(@MOVIEID,@MOVIETITLE,'UPDATE',GETDATE())
END

create trigger TR_DELETE_instead
ON MOVIES
INSTEAD OF DELETE
AS
BEGIN
DECLARE @MOVIEID INT
DECLARE @MOVIETITLE VARCHAR(100)

SELECT @MOVIEID= MOVIEID FROM DELETED
SELECT @MOVIETITLE= MOVIETITLE FROM DELETED

INSERT INTO MoviesLog VALUES(@MOVIEID,@MOVIETITLE,'DELETE',GETDATE())
END
--2.	Create a trigger that only allows to insert movies for which Rating is greater than 5.5 .
CREATE TRIGGER TR_RATING
ON MOVIES
INSTEAD OF INSERT
AS
BEGIN 
DECLARE @M
--3.	Create trigger that prevent duplicate 'MovieTitle' of Movies table and log details of it in MoviesLog table.

--4.	Create trigger that prevents to insert pre-release movies.

--5.	Develop a trigger to ensure that the Duration of a movie cannot be updated to a value greater than 120 minutes (2 hours) to prevent unrealistic entries.

