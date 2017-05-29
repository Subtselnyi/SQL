----  Task1
--use [master]
--CREATE DATABASE [LazyStudent]
--GO
--use [LazyStudent]
--GO


--CREATE TABLE [Clients] (
--    [ClientId] INT IDENTITY(1,1) NOT NULL,
--    [FirstName] NVARCHAR(32) NOT NULL,
--	  [MiddletName] NVARCHAR(32) NOT NULL,
--    [SurName] NVARCHAR(32) NOT NULL,
--    [Phone] TINYINT NOT NULL,
--    [E-mail] NVARCHAR(64) UNIQUE NOT NULL,
--    [Password] NVARCHAR(32) NOT NULL,
--    [RegDate] DATE NOT NULL,
--    PRIMARY KEY (ClientId)
--)


--CREATE TABLE [Subjects](
--		[SubjectId] INT IDENTITY(1,1) NOT NULL,
--		[SubjectName] NVARCHAR(64) NOT NULL,
--		PRIMARY KEY (SubjectId)
--)

--CREATE TABLE [Tutor](
--		[TutorId] INT IDENTITY(1,1) NOT NULL,
--		[FirstName] NVARCHAR(32) NOT NULL,
--		[MiddletName] NVARCHAR(32) NOT NULL,
--		[SurName] NVARCHAR(32) NOT NULL,
--		[Phone] TINYINT NOT NULL,
--		[E-mail] NVARCHAR(64) UNIQUE NOT NULL,
--      [Price] INT NOT NULL,
--		[Rating] TINYINT,
--		[TotalVoted] INT,
--		PRIMARY KEY (TutorId)
--)

--CREATE TABLE [TutorSubjects](
--		[TutorId] INT NOT NULL,
--		[SubjectId] INT NOT NULL,
--		PRIMARY KEY (TutorId),
--		FOREIGN KEY (TutorId) REFERENCES Tutor(TutorId),
--		FOREIGN KEY (SubjectId) REFERENCES Subjects(SubjectId)
--)

--CREATE TABLE [Companies](
--		[CompanyId] INT IDENTITY(1,1) NOT NULL,
--		[CompanyName] NVARCHAR(64) NOT NULL,
--		[Phone] TINYINT,
--		[E-mail] NVARCHAR(64) NOT NULL,
--		PRIMARY KEY (CompanyId)
--)

--CREATE TABLE [CompanySubjects](
--		[CompanyId] INT NOT NULL,
--		[SubjectId] INT NOT NULL,
--		PRIMARY KEY (CompanyId),
--		FOREIGN KEY (CompanyId) REFERENCES Companies(CompanyId),
--		FOREIGN KEY (SubjectId) REFERENCES Subjects(SubjectId)
--)

--CREATE TABLE [TutorOrders](
--		[OrderId] INT IDENTITY(1,1) NOT NULL,
--		[ClientId] INT NOT NULL,
--		[SubjectId] INT NOT NULL,
--      [TutorId] INT NOT NULL,
--		[Amount] INT NOT NULL DEFAULT 1,
--		[DateOrder] DATE NOT NULL DEFAULT GETDATE(),
--		[Discount] TINYINT NOT NULL DEFAULT 0,
--		[Status] TINYINT NOT NULL
--		PRIMARY KEY (OrderId),
--		FOREIGN KEY (ClientId) REFERENCES Clients(ClientId),
--		FOREIGN KEY (SubjectId) REFERENCES Subjects(SubjectId),
--      FOREIGN KEY (TutorId) REFERENCES Tutor(TutorId)
--)

--CREATE TABLE [CompanyOrders](
--		[OrderId] INT IDENTITY(1,1) NOT NULL,
--		[ClientId] INT NOT NULL,
--		[SubjectId] INT NOT NULL,
--		[CompanyId] INT NOT NULL,
--		[Amount] INT NOT NULL DEFAULT 1,
--		[DateOrder] DATE NOT NULL DEFAULT GETDATE(),
--		[Discount] TINYINT NOT NULL DEFAULT 0,
--		[Status] TINYINT NOT NULL
--		PRIMARY KEY (OrderId),
--		FOREIGN KEY (ClientId) REFERENCES Clients(ClientId),
--		FOREIGN KEY (SubjectId) REFERENCES Subjects(SubjectId),
--		FOREIGN KEY (CompanyId) REFERENCES Companies(CompanyId)
--)