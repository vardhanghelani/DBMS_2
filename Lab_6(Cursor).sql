CREATE TABLE Products (
    Product_id INT PRIMARY KEY,
    Product_Name VARCHAR(250) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL
);
INSERT INTO Products (Product_id, Product_Name, Price) VALUES
(1, 'Smartphone', 35000),
(2, 'Laptop', 65000),
(3, 'Headphones', 5500),
(4, 'Television', 85000),
(5, 'Gaming Console', 32000);

--Part - A 
--1. Create a cursor Product_Cursor to fetch all the rows from a products table. 
DECLARE 
@Product_id INT,
@Product_name varchar(250),
@price decimal(8,2)

DECLARE Product_Cursor CURSOR
FOR SELECT 
Product_id,
Product_Name,
Price

FROM Products;

OPEN Product_Cursor;
FETCH NEXT FROM Product_Cursor INTO
@Product_id,
@Product_name,
@price;

WHILE @@FETCH_STATUS=0
	BEGIN
		SELECT @Product_id,@Product_name,@price
		FETCH NEXT FROM Product_Cursor INTO
		@Product_id,
		@Product_name,
		@price;
	END
CLOSE Product_Cursor;
DEALLOCATE Product_Cursor;
--2. Create a cursor Product_Cursor_Fetch to fetch the records in form of ProductID_ProductName. 
--(Example: 1_Smartphone) 
DECLARE
@Product_id INT,
@Product_name VARCHAR(100);
DECLARE Product_Cursor_Fetch CURSOR
FOR SELECT 
Product_id,
Product_Name
FROM Products;

OPEN Product_Cursor_Fetch;
FETCH NEXT FROM Product_Cursor_Fetch INTO
@Product_id,
@Product_name;
WHILE @@FETCH_STATUS=0
BEGIN 
  PRINT CAST(@Product_id AS VARCHAR) +'_'+@Product_name;
  FETCH NEXT FROM Product_Cursor_Fetch INTO
@Product_id,
@Product_name;
END
CLOSE Product_Cursor_Fetch;
DEALLOCATE Product_Cursor_Fetch

--3. Create a Cursor to Find and Display Products Above Price 30,000. 
DECLARE
@P_name varchar(100)
DECLARE Product_Above_30000 cursor
for select 
Product_Name
from Products
where Price>30000;

open Product_Above_30000;
fetch next from Product_Above_30000 into
@P_name
while @@FETCH_STATUS =0
begin 
	 print @P_name
	fetch next from Product_Above_30000 into
@P_name
end
close Product_Above_30000
deallocate Product_Above_30000
--4. Create a cursor Product_CursorDelete that deletes all the data from the Products table.
declare
@P_id int
declare Product_CursorDelete cursor
for select 
Product_id
from Products
open Product_CursorDelete;
fetch next from Product_CursorDelete into 
@P_id
while @@FETCH_STATUS=0
begin 
 delete from Products where Product_id=@P_id
 fetch next from Product_CursorDelete into 
@P_id
end
close Product_CursorDelete
deallocate Product_CursorDelete
--Part – B 
--5. Create a cursor Product_CursorUpdate that retrieves all the data from the products table and increases 
--the price by 10%
declare 
@P_id int;
declare Product_CursorUpdate cursor 
for select 
Product_id
from Products
open Product_CursorUpdate
fetch next from Product_CursorUpdate into
@P_id;

while @@FETCH_STATUS=0
begin 
 update Products set Price=Price+(Price*0.1) where Product_id=@P_id
 fetch next from Product_CursorUpdate into
@P_id;
end 

close Product_CursorUpdate
deallocate Product_CursorUpdate
--6. Create a Cursor to Rounds the price of each product to the nearest whole number.
declare 
@P1_id int
declare Cursor_priceRound cursor
for select 
Product_id
from Products
open Cursor_priceRound;
fetch next from Cursor_priceRound into
@P1_id
while @@FETCH_STATUS=0
begin 
 update Products set Price=ROUND(Price,0) where Product_id=@P1_id

 fetch next from Cursor_priceRound into
@P1_id
end
close Cursor_priceRound
deallocate Cursor_priceRound 
--Part – C 
--7. Create a cursor to insert details of Products into the NewProducts table if the product is “Laptop” 
--(Note: Create NewProducts table first with same fields as Products table) 
CREATE TABLE NewProducts (
    Product_id INT PRIMARY KEY,
    Product_Name VARCHAR(250) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL
);


declare @P_id int, @P_Name varchar(250), @P_Price decimal(10, 2);
declare Cursor_InaerIntoTable cursor 
for 
select Product_id, Product_Name, Price 
from Products
where Product_Name = 'Laptop';

open Cursor_InaerIntoTable;

fetch next from Cursor_InaerIntoTable into @P_id, @P_Name, @P_Price;

while @@FETCH_STATUS=0
begin
    insert into NewProducts (Product_id, Product_Name, Price)
    values (@P_id, @P_Name, @P_Price);

  
    fetch next from Cursor_InaerIntoTable into @P_id, @P_Name, @P_Price;
end 


close Cursor_InaerIntoTable;
deallocate Cursor_InaerIntoTable;

--8. Create a Cursor to Archive High-Price Products in a New Table (ArchivedProducts), Moves products 
--with a price above 50000 to an archive table, removing them from the original Products table. 
CREATE TABLE ArchiveProducts (
    Product_id INT PRIMARY KEY,
    Product_Name VARCHAR(250) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL
);
declare @P_id int,@P_name varchar(50),@P_price decimal(8,2)
declare Cursor_Archive cursor
for select
Product_id,
Product_Name,
Price
from Products
where price>50000
open Cursor_Archive
fetch next from Cursor_Archive into 
@P_id,
@P_name,
@P_price

while @@FETCH_STATUS=0
begin 
     insert into ArchiveProducts(Product_id,Product_Name,Price)
	 values (@P_id,@P_name,@P_price);
	 delete  from Products where Product_id=@P_id
	fetch next from Cursor_Archive into 
@P_id,
@P_name,
@P_price
end
close Cursor_Archive
deallocate Cursor_Archive
select *from ArchiveProducts
select *from Products