--Task 1
INSERT INTO [NORTHWND].[dbo].[Employees]
           ([LastName]
           ,[FirstName]
           ,[Title]
           ,[TitleOfCourtesy]
           ,[BirthDate]
           ,[HireDate]
           ,[Address]
           ,[City]
           )
     VALUES
           ('Subtselnyi'
           ,'Alexander'
           ,'Intern'
           ,'Mr.'
           ,'1998-03-27'
           ,GETDATE()
           ,'Yangelya 20,524'
           ,'Kyiv'
           )


--Task2
UPDATE [NORTHWND].[dbo].[Employees]
SET [Title] = 'Director' 
WHERE [LastName] = 'Subtselnyi'


--Task3
SELECT * INTO [NORTHWND].[dbo].[OrdersArchive]
FROM [NORTHWND].[dbo].[Orders]

--Task4
TRUNCATE TABLE [NORTHWND].[dbo].[OrdersArchive]
--DELETE FROM [NORTHWND].[dbo].[OrdersArchive]

--Task5
SET IDENTITY_INSERT [NORTHWND].[dbo].[OrdersArchive] ON;
GO  
INSERT INTO [NORTHWND].[dbo].[OrdersArchive] ([OrderID]
	  ,[CustomerID]
      ,[EmployeeID]
      ,[OrderDate]
      ,[RequiredDate]
      ,[ShippedDate]
      ,[ShipVia]
      ,[Freight]
      ,[ShipName]
      ,[ShipAddress]
      ,[ShipCity]
      ,[ShipRegion]
      ,[ShipPostalCode]
      ,[ShipCountry])
SELECT * FROM [NORTHWND].[dbo].[Orders]
SET IDENTITY_INSERT [NORTHWND].[dbo].[OrdersArchive] OFF;
GO

--Task6
DELETE FROM [NORTHWND].[dbo].[OrdersArchive]
WHERE [ShipCity] = 'Berlin'


--Task7
INSERT INTO [NORTHWND].[dbo].[Products]
           ([ProductName])
     VALUES
           ('Alexander'),('IP-51');


--Task8
UPDATE [NORTHWND].[dbo].[Products]
SET [Discontinued] = 1
WHERE ProductID != ANY (SELECT DISTINCT ProductID FROM [NORTHWND].[dbo].[Order Details])


--Task9
DROP TABLE [NORTHWND].[dbo].[OrdersArchive];


--Task10
DROP DATABASE NORTHWND;