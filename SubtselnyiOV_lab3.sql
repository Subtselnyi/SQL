--   Task 1
--SELECT 'Oleksandr Volodymyrovich'  AS 'Name'
--UNION
--SELECT 'Subtselnyi' ;

--   Task2
--IF (SELECT [StudentID] FROM [KPI].[dbo].[IP-51] 
--	WHERE [surname] = 'Subtselnyi' < ALL (SELECT [StudentID] FROM [KPI].[dbo].[IP-51])
--PRINT N';-)'
--ELSE
--PRINT N':-D';

--   Task3
--IF (SELECT [Name],[Surname] FROM [KPI].[dbo].[IP-51] 
--DECLARE @name NVARCHAR(100)
--DECLARE @id INT
--SET @id = 1
--WHILE (SELECT COUNT([id]) FROM [NORTHWND].[dbo].[IP-51]) >= @id
--BEGIN
--	IF ((SELECT [name] FROM [KPI].[dbo].[IP-51] WHERE [id] = @id) != 
--		ALL(SELECT DISTINCT [name] FROM [KPI].[dbo].[IP-52]))
--		BEGIN
--			SELECT @name = (SELECT [surname] FROM [KPI].[dbo].[IP-51] WHERE [id] = @id )
--			SET @name += (SELECT [name] FROM [KPI].[dbo].[IP-51] WHERE [id] = @id)
--			PRINT @name
--		END
--	SET @id += 1
--END


--   Task4
--SELECT *,[CharNumber] =
--CASE [NUMBER] 
--			WHEN 0 THEN 'NULL'
--			WHEN 1 THEN 'ONE'
--			WHEN 2 THEN 'TWO'
--			WHEN 3 THEN 'THREE'
--			WHEN 4 THEN 'FOUR'
--			WHEN 5 THEN 'FIVE'
--			WHEN 6 THEN 'SIX'
--			WHEN 7 THEN 'SEVEN'
--			WHEN 8 THEN 'EIGHT'
--			WHEN 9 THEN 'NINE'
--			ELSE CAST([NUMBER] AS varchar)
--END
--FROM [NORTHWND].[dbo].[NUMBERS]


--   Task5
--SELECT *FROM table1 CROSS JOIN table2
--to make query like 
--SELECT * FROM table1 JOIN table2 ON table1.id = table2.fk_id
--With help of CROSS JOIN
--SELECT * FROM table1 CROSS JOIN table2 WHERE table1.id = table2.fk_id


-----------------------------PART2
--   Task1
----Create table without SHipVia column
--SELECT * INTO #TemporaryTable FROM [NORTHWND].[dbo].[Orders]
--ALTER TABLE #TemporaryTable DROP COLUMN [ShipVia]
----Joining 2 tables
--SELECT #TemporaryTable.*, (CASE NT.[ShipVia]
--								WHEN 1 THEN 'Subtselnyi'
--								WHEN 2 THEN 'Oleksandr'
--								WHEN 3 THEN 'Volodymyrovich'
--								ELSE CAST([ShipVia] AS varchar)
--								END) AS 'ShipVia' 
--						   FROM  #TemporaryTable
--JOIN [NORTHWND].[dbo].[Orders] AS NT
--ON #TemporaryTable.[OrderID] = NT.[OrderID]
--DROP TABLE #TemporaryTable

--   Task2
--SELECT [Country] FROM [NORTHWND].[dbo].[Customers]
--UNION
--SELECT [Country] FROM [NORTHWND].[dbo].[Employees]
--UNION
--SELECT [ShipCountry] FROM [NORTHWND].[dbo].[Orders]
--ORDER BY [Country]

--   Task3
--SELECT [FirstName], [LastName], COUNT(*)  FROM [NORTHWND].[dbo].[Employees] AS EMP
--LEFT JOIN [NORTHWND].[dbo].[Orders] AS ORD
--ON EMP.[EmployeeID] = ORD.[EmployeeID]
--WHERE YEAR(ORD.[OrderDate]) = 1998 AND MONTH(ORD.[OrderDate]) <=3
--GROUP BY EMP.[LastName], EMP.[FirstName]


--   Task4
--WITH OrderCTE ([OrderID]) AS (
--	SELECT DISTINCT [OrderID]
--	FROM [NORTHWND].[dbo].[Order Details] 
--	WHERE [ProductID] = ANY(SELECT DISTINCT [ProductID]
--							FROM [NORTHWND].[dbo].[Order Details]
--							GROUP BY [ProductID]
--							HAVING SUM([Quantity]) > 100)
--	AND ([Discount] < (SELECT MAX([Discount]) 
--				      FROM [NORTHWND].[dbo].[Order Details])))

--SELECT * FROM [NORTHWND].[dbo].[Orders] 
--WHERE [OrderID] IN (SELECT [OrderID] FROM OrderCTE)