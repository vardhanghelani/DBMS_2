--Part – A 
--1. Write a function to print "hello world". 
CREATE OR ALTER FUNCTION FN_HELLO_WORLD()
RETURNS VARCHAR(50)
AS
BEGIN
	RETURN 'HELLO WORLD'
END
SELECT DBO.FN_HELLO_WORLD()
--2. Write a function which returns addition of two numbers.
CREATE OR ALTER FUNCTION FN_SUM(
@NUM1 INT,
@NUM2 INT)
RETURNS INT
AS 
BEGIN
	RETURN @NUM1+@NUM2
END
SELECT DBO.FN_SUM(1,2)
--3. Write a function to check whether the given number is ODD or EVEN. 
CREATE OR ALTER FUNCTION FN_ODD_EVEN(@NUM INT)
RETURNS VARCHAR(50)
AS 
BEGIN
	IF(@NUM%2=0)
		RETURN 'EVEN'
	RETURN 'ODD'
END
SELECT DBO.FN_ODD_EVEN(5)

--4. Write a function which returns a table with details of a person whose first name starts with B. 
CREATE OR ALTER FUNCTION FN_START_WITH_B()
RETURNS TABLE
AS

	RETURN(SELECT * FROM Person WHERE FirstName LIKE 'B%')
SELECT * FROM DBO.FN_START_WITH_B()
--5. Write a function which returns a table with unique first names from the person table.
CREATE OR ALTER FUNCTION FN_UNIQUE_NAME()
RETURNS TABLE
AS
	RETURN(SELECT DISTINCT FIRSTNAME FROM Person)
SELECT FIRSTNAME FROM DBO.FN_UNIQUE_NAME()
--6. Write a function to print number from 1 to N. (Using while loop) 
CREATE OR ALTER FUNCTION FN_1_TO_N(@N INT)
RETURNS VARCHAR(50)
AS
BEGIN
	DECLARE @NUMS VARCHAR(50), @COUNT INT
	SET @COUNT=1
	SET @NUMS=''
	WHILE(@COUNT<=@N)
	BEGIN
		SET @NUMS=@NUMS+CAST(@COUNT AS varchar)+','
		SET @COUNT=@COUNT+1
	END
	RETURN @NUMS
END
SELECT DBO.FN_1_TO_N(10)
--7. Write a function to find the factorial of a given integer. 
CREATE OR ALTER FUNCTION FN_FAC(@N INT)
RETURNS INT
AS
BEGIN
	DECLARE @FAC INT, @COUNT INT 
	SET @FAC=1
	SET @COUNT=1
	WHILE(@COUNT<=@N)
	BEGIN
		SET @FAC=@FAC*@COUNT
		SET @COUNT=@COUNT+1
		END
	RETURN @FAC
END
SELECT DBO.FN_FAC(5)
--Part – B 
--8. Write a function to compare two integers and return the comparison result. (Using Case statement) 
--9. Write a function to print the sum of even numbers between 1 to 20. 
--10. Write a function that checks if a given string is a palindrome 
--Part – C 
--11. Write a function to check whether a given number is prime or not. 
--12. Write a function which accepts two parameters start date & end date, and returns a difference in days. 
--13. Write a function which accepts two parameters year & month in integer and returns total days each 
--year. 
--14. Write a function which accepts departmentID as a parameter & returns a detail of the persons. 
--15. Write a function that returns a table with details of all persons who joined after 1-1-1991.