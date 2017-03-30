--   Task1
CREATE DATABASE subtselnyi;

--   Task2
CREATE TABLE Student (
    StudentID int NOT NULL,
    SecondName varchar(255),
    FirstName varchar(255),
    Sex bit,
    PRIMARY KEY (StudentID)
); 

--   Task3
--   if it had "NOT NULL"
ALTER TABLE Student
ADD PRIMARY KEY (StudentID);
--   if the column had no "NOT NULL" specs => firstly to execute this 2 lines
UPDATE Student SET StudentID=0 WHERE StudentID IS NULL;
ALTER TABLE Student ALTER COLUMN StudentID INT NOT NULL;

--   Task4
--We cant just add identity(AUTO_INCREMENT) to Primary Key? we need to drop column
ALTER TABLE dbo.Student
DROP CONSTRAINT PK__Student__32C52A79F2B63D20;
ALTER TABLE Student
DROP COLUMN StudentID;
ALTER TABLE Student 
ADD StudentID INT NOT NULL IDENTITY (1,1) PRIMARY KEY;

--   Task5
ALTER TABLE Student
ADD BirthDate date;


--   Task6
ALTER TABLE Student
ADD CurrentAGE AS convert(int,DATEDIFF(d, [BirthDate], getdate())/365.25)

--  Task7
ALTER TABLE Student
ALTER COLUMN Sex Char(1) NOT NULL
ALTER TABLE Student
ADD CONSTRAINT CHK_Sex CHECK (Sex='m' OR Sex='f');

--  Task8
INSERT INTO [Student]
           ([SecondName]
           ,[FirstName]
           ,[Sex]
           ,[BirthDate])
     VALUES
           ('Starchenko'
           ,'Anastasiya'
           ,'f'
           ,'1998-07-18'),
		   ('Subtselnyi'
		   ,'Alexander'
		   ,'m'
		   ,'1998-03-27'),
		   ('Huda'
		   ,'Anna'
		   ,'f'
		   ,'1998-12-25')


--  Task9
CREATE VIEW vMaleStudent AS
SELECT *
FROM Student
WHERE Sex='m';

CREATE VIEW vFemaleStudent AS
SELECT *
FROM Student
WHERE Sex='f';

SELECT * FROM vMaleStudent;
SELECT * FROM vFemaleStudent;

--  Task10
ALTER TABLE Student
DROP CONSTRAINT PK__Student__32C52A79AC40A7E8;
ALTER TABLE Student
ALTER COLUMN StudentID SmallInt;
ALTER TABLE Student
ADD PRIMARY KEY (StudentID);