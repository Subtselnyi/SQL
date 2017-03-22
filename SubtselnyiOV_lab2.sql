--    Task1
----    example for MS SQL
SELECT COUNT_BIG(*) AS 'Number of Rows' FROM [TableName];
----    example for MySQL (count() in MySQL always returns BIGINT)
SELECT COUNT(*) FROM 'tablename';
----    and if an approximation is enough we can use:
SHOW TABLE STATUS LIKE 'tablename';

--    Task2
SELECT LEN('Subtselnyi') AS 'Surname';

--    Task3
SELECT REPLACE('Subtselnyi Alexander Vladimirovich',' ','_') AS 'Ï²Á';

--    Task4
SELECT CONCAT(LEFT([Name], 2), LEFT([Surname], 4), '@subtselnyi.com') AS 'email' FROM [TableName];

--    Task5
SELECT DATENAME(DW, '1998-03-27') AS 'Day of Birth';

---------------------------------------Part 2


--   Task1
SELECT * FROM [NORTHWND].[dbo].[Products] AS PR
RIGHT JOIN [NORTHWND].[dbo].[Categories] AS CT ON 
		 PR.[CategoryID] = CT.[CategoryID]
RIGHT JOIN [NORTHWND].[dbo].[Suppliers] AS SP ON
		 SP.[SupplierID] = PR.[SupplierID];

--   Task2
SELECT * FROM [NORTHWND].[dbo].[Orders]
WHERE ([ShippedDate] IS NULL)  AND
      ([OrderDate] BETWEEN '1998-04-01' AND '1998-04-30');

--   Task3
SELECT DISTINCT [FirstName],
	   [LastName] 
FROM [NORTHWND].[dbo].[Employees] AS EMP
JOIN [NORTHWND].[dbo].[EmployeeTerritories] AS ET ON
     EMP.[EmployeeID] = ET.[EmployeeID]
JOIN [NORTHWND].[dbo].[Territories] AS TT ON
	 TT.[TerritoryID] = ET.[TerritoryID]
JOIN [NORTHWND].[dbo].[Region] AS RG ON
	 RG.[RegionID] = TT.[RegionID]
WHERE RG.[RegionDescription] = 'Northern';

--  Task4
SELECT CAST(SUM([Quantity]*[UnitPrice]*(1-[Discount])) AS decimal(10,2)) AS 'Total Price'
FROM [NORTHWND].[dbo].[Order Details] AS OD
WHERE OD.[OrderID] IN 
( SELECT [OrderID] FROM [NORTHWND].[dbo].[Orders] AS ORD
  WHERE	(DATENAME(dd, ORD.[OrderDate])%2=1));	

--  Task5
SELECT ORD.[ShipAddress]
FROM [NORTHWND].[dbo].[Orders] AS ORD
WHERE ORD.[OrderID] IN 
(SELECT  [OrderID] 
 FROM [NORTHWND].[dbo].[Order Details] AS OD
 GROUP BY OD.[OrderID]
 HAVING SUM([Quantity]*[UnitPrice]*(1-[Discount])) = (SELECT TOP(1) (SUM([Quantity]*[UnitPrice]*(1-[Discount])))
                                                      FROM [NORTHWND].[dbo].[Order Details]
                                                      GROUP BY [OrderID]
                                                      ORDER BY (SUM([Quantity]*[UnitPrice]*(1-[Discount]))) DESC )
)


--  Task5 New Variant with CTE and MAX
WITH [SumOD] AS (SELECT SUM([Quantity]*[UnitPrice]*(1-[Discount])) AS 'TotalOrderSum'
                  FROM [NORTHWND].[dbo].[Order Details]
                  GROUP BY [OrderID])


SELECT [ShipAddress]
FROM [NORTHWND].[dbo].[Orders]
WHERE [OrderID] IN (SELECT [OrderID] FROM [NORTHWND].[dbo].[Order Details] AS OD
				    GROUP BY OD.[OrderID]
                    HAVING SUM([Quantity]*[UnitPrice]*(1-[Discount])) = (SELECT MAX([TotalOrderSum]) FROM [SumOD]))