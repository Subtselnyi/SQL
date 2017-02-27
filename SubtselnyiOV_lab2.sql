--    TAsk1
--    example for MS SQL
--SELECT COUNT_BIG(*) AS 'Number of Rows' FROM [TableName];
--    example for MySQL (count() in MySQL always returns BIGINT)
--SELECT COUNT(*) FROM 'tablename';
--    and if an approximation is enough we can use:
--SHOW TABLE STATUS LIKE 'tablename';

--    Task2
--SELECT LEN('SUBTSELNYI') AS 'Surname';

--    Task3
--SELECT REPLACE('Subtselnyi Alexander Vladimirovich',' ','_') AS 'Ï²Á';

--    Task4
--SELECT CONCAT(LEFT([Name], 2), LEFT([Surname], 4), '@subtselnyi.com') AS 'email' FROM [TableName];

--    Task5
--SELECT DATENAME(DW, '1998-03-27') AS 'Day of Birth';

