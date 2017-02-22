 --Task1
--Print firstname, middlename, lastname
SELECT 'Alexander' AS FirstName,
	   'Vladimirovich' AS MiddleName,
	   'Subtselnyi' AS LastName

--Task2
--All data from Products
SELECT * from [NORTHWND].[dbo].[Products]

--Task3
--select all that are discontinued from products
SELECT * from [NORTHWND].[dbo].[Products] WHERE Discontinued = '1'

--Task4
--All unique customers cities
SELECT DISTINCT "City" from [NORTHWND].[dbo].[Customers]

--Task5
--select all companynames in decreasing way
SELECT "CompanyName" from [NORTHWND].[dbo].[Suppliers] ORDER BY "CompanyName" DESC

--TASK6
--get all orders, change columns for numbers
SELECT 
	OrderID AS '1', 
	ProductID AS '2',
	UnitPrice AS '3',
	Quantity AS '4',
	Discount AS '5'
FROM [NORTHWND].[dbo].[Order Details]


--Task7
--all contact names that begin with tha letter A,V,S (Alexander Vladimirovich Subtselnyi)
SELECT "ContactName" from [NORTHWND].[dbo].[Customers] WHERE "ContactName" LIKE '[AVS]%'

--Task8
--select all orders where _ is detected in address
SELECT * from [NORTHWND].[dbo].[Orders] WHERE "ShipName" LIKE '% %'

--Task9
--select all products that start with % or _ and end on 'r'
SELECT "ProductName" from [NORTHWND].[dbo].[Products] WHERE "ProductName" LIKE '[%_]%[rR]'
