--   Task1

CREATE PROCEDURE greetings AS 
	SELECT 'Alexander Subtselnyi' AS 'Welcome' 


--  Task2
CREATE PROCEDURE getWorkers (@sex CHAR(1)) AS
	BEGIN
	     IF LOWER(@sex) = 'm'
		    (SELECT * FROM [NORTHWND].[dbo].[Employees]
		    WHERE [TitleOfCourtesy] IN ('Mr.', 'Dr.'))
		 IF LOWER(@sex) = 'f'
			(SELECT * FROM [NORTHWND].[dbo].[Employees]
		     WHERE [TitleOfCourtesy] IN ('Mrs.', 'Ms.'))
		 ELSE
			 SELECT 'Incorrect input'
	 END


--   Task3
CREATE PROCEDURE getOrders (@from DATE = NULL, @to DATE = NULL) AS 
    BEGIN	
        IF @from = NULL
            SET @from = DATEADD(DD, -1, CAST(GETDATE() AS DATE))
        IF @to = NULL
            SET @to = GETDATE()
        SELECT * FROM [NORTHWND].[dbo].[Orders]
        WHERE [OrderDate] BETWEEN @from AND  @to
    END


--   Task4
CREATE PROCEDURE getCategory (@categoryId1 INT,@categoryId2 INT = NULL,@categoryId3 INT = NULL,@categoryId4 INT = NULL,@categoryId5 INT = NULL) AS
SELECT * FROM [dbo].[Products]
      WHERE [CategoryID] IN (@categoryId1,@categoryId2,@categoryId3,@categoryId4,@categoryId5)

--   Task5
ALTER PROCEDURE [Ten Most Expensive Products] AS
    BEGIN
        SELECT TOP (10) 
                [P].[ProductName] AS [TenMostExpensiveProducts] 
               ,[P].[SupplierID]
			   ,[S].[CompanyName]
               ,[P].[CategoryID]
			   ,[C].[CategoryName]
               ,[QuantityPerUnit]
               ,[UnitPrice]
               ,[UnitsInStock]
               ,[UnitsOnOrder]
               ,[ReorderLevel]
               ,[Discontinued]
        FROM [Products] AS [P]
        LEFT JOIN [dbo].[Suppliers] AS [S]
            ON [S].[SupplierID] = [P].[SupplierID]
        LEFT JOIN [dbo].[Categories] AS [C]
            ON [C].[CategoryID] = [P].[CategoryID]
        ORDER BY [UnitPrice] DESC
    END 


--   Task6
CREATE FUNCTION concatName ( @TitleOfCourtesy NVARCHAR(10),@FirstName AS NVARCHAR(20), @LastName NVARCHAR(50))
RETURNS NVARCHAR(82) AS
    BEGIN
        RETURN CONCAT(@TitleOfCourtesy, ' ', @FirstName, ' ', @LastName)
	END

PRINT [NORTHWND].[dbo].[concatName]('Dr.', 'Yevhen', 'Nedashkivskyi')

--  Task7
CREATE FUNCTION calculate (@UnitPrice MONEY, @Quantity INT, @Discount  DECIMAL(18, 2))
RETURNS MONEY
AS
    BEGIN
        RETURN @UnitPrice*@Quantity*(1 - @Discount)
    END

PRINT [NORTHWND].[dbo].[calculate] (2, 2, 0.5)


--  Task8

CREATE FUNCTION PascalCase (@Str VARCHAR(8000)) 
RETURNS VARCHAR(8000) AS 
BEGIN   
DECLARE @Result VARCHAR(2000)   
SET @Str = LOWER(@Str) + ' '   
SET @Result = ''   
WHILE 1=1   
BEGIN     
IF PATINDEX('% %',@Str) = 0 
BREAK     
SET @Result = @Result + UPPER(Left(@Str,1))+     SubString  (@Str,2,CharIndex(' ',@Str)-2)     
SET @Str = SubString(@Str,       CharIndex(' ',@Str)+1,Len(@Str))   
END   
SET @Result = Left(@Result,Len(@Result))   
RETURN @Result 
END 

PRINT [dbo].[PascalCase]('My little poni')

--  Task9

CREATE FUNCTION employeeInfo
(
    @country NVARCHAR(50)
)
RETURNS @employeeTable TABLE (  [EmployeeID] INT NOT NULL,
								[LastName] NVARCHAR(20) NOT NULL,
								[FirstName] NVARCHAR(10) NOT NULL,
								[Title] NVARCHAR(30) NULL,
								[TitleOfCourtesy] NVARCHAR(25) NULL,
								[BirthDate] DATETIME NULL,
								[HireDate]  DATETIME NULL,
								[Address] NVARCHAR(60) NULL,
								[City] NVARCHAR(15) NULL,
								[Region] NVARCHAR(15) NULL,
								[PostalCode] NVARCHAR(10) NULL,
								[Country] NVARCHAR(15) NULL,
								[HomePhone] NVARCHAR(24) NULL,
								[Extension] NVARCHAR(4) NULL,
								[Photo] IMAGE NULL,
								[Notes] NTEXT NULL,
								[ReportsTo] INT NULL,
								[PhotoPath] NVARCHAR(255) NULL) AS
    BEGIN
        INSERT INTO @employeeTable 
        SELECT * FROM [NORTHWND].[dbo].[Employees]
        WHERE [Country] = @country
		RETURN
    END

SELECT * FROM [NORTHWND].[dbo].[employeeInfo]('USA')

--  Task10


CREATE FUNCTION customersOfCompany
(
    @companyName NVARCHAR(80)
)
RETURNS @customerTable TABLE(   [CustomerID] NCHAR(5) NOT NULL,
								[CompanyName] NVARCHAR(40) NOT NULL,
								[ContactName] NVARCHAR(30) NULL,
								[ContactTitle] NVARCHAR(30) NULL,
								[Address] NVARCHAR(60) NULL,
								[City] NVARCHAR(15) NULL,
								[Region] NVARCHAR(15) NULL,
								[PostalCode] NVARCHAR(10) NULL,
								[Country] NVARCHAR(15) NULL,
								[Phone] NVARCHAR(24) NULL,
								[Fax] NVARCHAR(24) NULL) AS
    BEGIN
        INSERT INTO @customerTable
        SELECT * FROM [NORTHWND].[dbo].[Customers]
        WHERE [CompanyName] LIKE @companyName
        RETURN
    END

SELECT * FROM [NORTHWND].[dbo].[customersOfCompany]('Alfreds Futterkiste')


