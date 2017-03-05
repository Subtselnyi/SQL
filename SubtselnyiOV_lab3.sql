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
--IF ((SELECT [name] FROM [KPI].[dbo].[IP-51] WHERE [id] = @id) != 
--	ALL(SELECT DISTINCT [name] FROM [KPI].[dbo].[IP-52]))
--	BEGIN
--		SELECT @name = (SELECT [surname] FROM [KPI].[dbo].[IP-51] WHERE [id] = @id )
--		SET @name += (SELECT [name] FROM [KPI].[dbo].[IP-51] WHERE [id] = @id)
--		PRINT @name
--	END
--SET @id += 1;
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
--			END
--FROM [NORTHWND].[dbo].[NUMBERS]


--   Task5
--SELECT *FROM table1 CROSS JOIN table2
--to make query like 
--SELECT * FROM table1 JOIN table2 ON table1.id = table2.fk_id
--With help of CROSS JOIN
--SELECT * FROM table1 CROSS JOIN table2 WHERE table1.id = table2.fk_id


-----------------------------PART2
--   Task1
