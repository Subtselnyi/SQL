--   Task1
use NORTHWND;
SELECT substring(O.name, 1, 30) TableName ,I.rows NumberofRows
FROM sysobjects O
INNER JOIN sysindexes I
ON (O.id = I.id)
WHERE O.xtype = 'u'
AND I.indid < 2
ORDER BY O.name;

--   Task2
DECLARE @UserName NVARCHAR(128);

DECLARE usernames CURSOR FOR
    SELECT suser_sname(owner_sid)
    FROM sys.databases;

OPEN usernames;
FETCH NEXT FROM usernames INTO @UserName;

WHILE @@FETCH_STATUS = 0
    BEGIN
	    EXEC('GRANT SELECT TO ' + @UserName);
        FETCH NEXT FROM usernames INTO @UserName;
    END
CLOSE usernames;
DEALLOCATE usernames;

 --  Task3
USE [NORTHWND]
GO
DECLARE @TableName NVARCHAR(128);

DECLARE TableNames CURSOR FOR
    SELECT TABLE_NAME
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_NAME LIKE 'prod-%';

OPEN TableNames;
FETCH NEXT FROM TableNames INTO @TableName;

WHILE @@FETCH_STATUS = 0
    BEGIN
        EXEC('DENY ALL ON ' + @TableName + ' TO TestUser');
        FETCH NEXT FROM TableNames INTO @TableName;
    END
CLOSE TableNames;
DEALLOCATE TableNames;


--   Task4

USE [NORTHWND]
GO

CREATE PROCEDURE GetOrderDetail 
(
    @OrderID INT
)
AS
    BEGIN
        SELECT [OD].[OrderID],
               [P].[ProductName],
               ([OD].[UnitPrice] * (1 - [OD].[Discount]) * [OD].[Quantity]) AS 'Price'
        FROM [Order Details] AS [OD]
        INNER JOIN [Products] AS [P]
                   ON [P].[ProductID] = [OD].[ProductID];
    END
GO


DECLARE @OrderID INT;
        
DECLARE AllOrders CURSOR FOR
    SELECT [OrderID] 
    FROM [Orders];


OPEN AllOrders;
FETCH NEXT FROM AllOrders INTO @OrderID;

WHILE @@FETCH_STATUS = 0
    BEGIN
		EXEC GetOrderDetail @OrderID;

        FETCH NEXT FROM AllOrders INTO @OrderID;
    END
CLOSE AllOrders;
DEALLOCATE AllOrders;


--   Task5

DECLARE @name NVARCHAR(256);

DECLARE db_cursor CURSOR FOR 
    SELECT name 
    FROM master.dbo.sysdatabases

OPEN db_cursor
FETCH NEXT FROM db_cursor INTO @name

 WHILE @@fetch_status = 0
        BEGIN	
				EXEC ('use '+@name)
				DECLARE @tablename NVARCHAR(256)
				DECLARE tb_cursor CURSOR FOR 
					SELECT name FROM sysobjects WHERE type = 'U';
				OPEN tb_cursor
				FETCH NEXT FROM tb_cursor INTO @tablename
				 WHILE @@fetch_status = 0
					BEGIN
						EXEC('TRUNCATE TABLE'+ @tablename );
						FETCH NEXT FROM tb_cursor INTO @tablename
					END
				 CLOSE tb_cursor
				 DEALLOCATE tb_cursor
	END
	CLOSE db_cursor
	DEALLOCATE db_cursor


--   Task6
GO
CREATE TRIGGER DeleteAllExceptNums ON [Customers]
FOR INSERT AS
    BEGIN 
	    DECLARE @User NVARCHAR(256)
		DECLARE @Phone NVARCHAR(256)

        SELECT @User = INSERTED.CustomerID, @Phone = INSERTED.Phone FROM INSERTED

		WHILE @Phone LIKE '%[^0-9]%' SET @Phone=STUFF(@Phone,PATINDEX('%[^0-9]%',@Phone),1,'');
	    UPDATE [Customers]
	    SET [Phone] = @Phone
	    WHERE [CustomerID] = @User
    END


--   Task7
GO
use NORTHWND
GO

CREATE TRIGGER MakeDiscount ON [Order Details]
FOR INSERT AS
BEGIN 
	DECLARE @OrderId NVARCHAR(256)
	DECLARE @Price INT
	DECLARE @ProductId INT

    SELECT @Price = INSERTED.[UnitPrice] * INSERTED.[Quantity], 
           @OrderId = INSERTED.[OrderID], 
           @ProductID = INSERTED.[ProductID] 
    FROM INSERTED

	UPDATE [Order Details]
	SET [Discount] = CASE
						WHEN @price > 100
						THEN 0.05
	                    WHEN @price > 500
						THEN 0.15
	                    WHEN @price > 1000
	                    THEN 0.25
	                 END
	WHERE [OrderID] = @OrderId AND [ProductID] = @ProductId
END


--   Task8

CREATE TABLE [Contacts](
    ContactId INT NOT NULL PRIMARY KEY, 
    LastName NVARCHAR(256), 
    FirstName NVARCHAR(256), 
    PersonalPhone NVARCHAR(256), 
    WorkPhone NVARCHAR(256), 
    Email NVARCHAR(256), 
    PreferableNumber NVARCHAR(256)
)
GO

CREATE TRIGGER AddPhone ON [Contacts]
FOR INSERT AS
BEGIN 
	DECLARE @ContactId INT
	DECLARE @WorkPhone NVARCHAR(1024)
	DECLARE @PersonalPhone NVARCHAR(1024)

    SELECT @ContactId = INSERTED.[ContactId], 
           @WorkPhone = INSERTED.[WorkPhone], 
           @PersonalPhone = INSERTED.[PersonalPhone] 
    FROM INSERTED

	UPDATE [dbo].[Contacts]
	SET [PreferableNumber] = CASE
								 WHEN @WorkPhone is NULL
								 THEN @PersonalPhone
								 ELSE @WorkPhone
	                         END
	WHERE [ContactId] = @ContactId
END


--  Task9
GO
USE [NORTHWND]
GO

SELECT TOP 0 * INTO [OrdersArchive]
FROM [Orders]

ALTER TABLE [OrdersArchive] 
ADD DeletionDateTime DATE, 
    DeletedBy NVARCHAR(256)
GO



CREATE TRIGGER DeletedItemsToArchive ON [Orders]
FOR DELETE AS
BEGIN
	DECLARE @id INT

	SELECT @id = OrderID FROM Orders

	INSERT INTO [OrdersArchive]
	SELECT  CustomerID, 
	        EmployeeID, 
	        OrderDate, 
	        RequiredDate, 
	        ShippedDate, 
	        ShipVia, 
	        Freight, 
	        ShipName, 
	        ShipAddress, 
	        ShipCity, 
	        ShipRegion, 
	        ShipPostalCode, 
	        ShipCountry, 
	        GETDATE(), 
	        CURRENT_USER 
	FROM DELETED
END


--   Task10
CREATE TABLE [TriggerTable1](
	TriggerId INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	TriggerDate DATE
)

CREATE TABLE [TriggerTable2](
	TriggerId INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	TriggerDate DATE
)

CREATE TABLE [TriggerTable3](
	TriggerId INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	TriggerDate DATE
)
GO

CREATE TRIGGER Trigger1 ON [TriggerTable1]
FOR INSERT AS
BEGIN
	DECLARE @id INT

	SELECT @id = TriggerId 
    FROM INSERTED

	INSERT INTO TriggerTable2(TriggerDate) 
    VALUES(GETDATE())
END
GO

CREATE TRIGGER Trigger2 ON [TriggerTable2]
FOR INSERT AS
BEGIN
	DECLARE @id INT

	SELECT @id = TriggerId 
    FROM inserted

	INSERT INTO TriggerTable3(TriggerDate) 
    VALUES(GETDATE())
END
GO

CREATE TRIGGER Trigger3 ON [TriggerTable1]
FOR INSERT AS
BEGIN
	DECLARE @id INT

	SELECT @id = TriggerId 
    FROM inserted

	INSERT INTO TriggerTable1(TriggerDate) 
    VALUES(GETDATE())
END
GO

INSERT INTO dbo.[TriggerTable1] (TriggerDate) VALUES('2017-11-11');
-- В даному випадку відбувається рекусрія. При вставці рядка у першу таблицю викликається перший тригер,
-- який вставляє дані у другу таблицю, що у свою чергу викликає 2-ий тригер,що впише дані,
-- який викличе 3 тригер, отже відбувається "косвенная" - "побічна?" рекусрія. Відбулась вставка 6 строк,
--по 2 у кожну таблицю, тому що MSQL помітив це і зупинив процес. Щоб унеможливити побічну рекурсію потрібно
--задати nested triggers значення 0.

