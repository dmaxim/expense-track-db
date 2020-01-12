
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "ExpenseTrack"
:setvar DefaultFilePrefix "UsafConfiguration"
:setvar DefaultDataPath ""
:setvar DefaultLogPath ""

GO
:on error exit
GO


GO


USE [master];


GO

PRINT N'Creating $(DatabaseName)'

GO

CREATE DATABASE [$(DatabaseName)] COLLATE SQL_Latin1_General_CP1_CI_AS
GO


USE [$(DatabaseName)];

IF EXISTS (SELECT 1
           FROM   [sys].[databases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                NUMERIC_ROUNDABORT OFF,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_CLOSE_ON_COMMIT OFF,
                AUTO_CREATE_STATISTICS ON,
                AUTO_SHRINK OFF,
                AUTO_UPDATE_STATISTICS ON,
                RECURSIVE_TRIGGERS OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [sys].[databases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ALLOW_SNAPSHOT_ISOLATION OFF;
    END


GO
IF EXISTS (SELECT 1
           FROM   [sys].[databases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_UPDATE_STATISTICS_ASYNC OFF,
                DATE_CORRELATION_OPTIMIZATION OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [sys].[databases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF) 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [sys].[databases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (QUERY_CAPTURE_MODE = AUTO, OPERATION_MODE = READ_WRITE, DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_PLANS_PER_QUERY = 200, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), MAX_STORAGE_SIZE_MB = 100) 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [sys].[databases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
    END


GO
IF EXISTS (SELECT 1
           FROM   [sys].[databases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET TEMPORAL_HISTORY_RETENTION ON 
            WITH ROLLBACK IMMEDIATE;
    END


GO

PRINT N'Creating dbo.ExpenseClassification';

GO

CREATE TABLE dbo.ExpenseClassification
(
	ExpenseClassificationId TINYINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Expense_Classification_Id PRIMARY KEY CLUSTERED,
	ClassificationName varchar(100) NOT NULL
)


GO
PRINT N'Creating dbo.ExpenseOwner';

GO

CREATE TABLE dbo.ExpenseOwner
(
	ExpenseOwnerId SMALLINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Expense_Owner_Id PRIMARY KEY CLUSTERED,
	OwnerUserId VARCHAR(255) NOT NULL,
	FirstName VARCHAR(100) NOT NULL,
	LastName VARCHAR(100) NOT NULL
)

GO

PRINT N'Creating dbo.Expense with amount field'
GO

CREATE TABLE dbo.Expense
(
	ExpenseId INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Expense_id PRIMARY KEY CLUSTERED,
	ExpenseClassificationId TINYINT NOT NULL,
	ExpenseDescription VARCHAR(255) NOT NULL,
	ExpenseOwnerId SMALLINT NOT NULL,
	IncurredDate DATETIMEOFFSET NOT NULL CONSTRAINT DF_Expense_Incurred_Date DEFAULT(GETUTCDATE()),
  Amount DECIMAL(8,2) NOT NULL, 
	CONSTRAINT FK_Expense_Classification FOREIGN KEY (ExpenseClassificationId) REFERENCES dbo.ExpenseClassification(ExpenseClassificationId),
	CONSTRAINT FK_Expense_Owner FOREIGN KEY (ExpenseOwnerId) REFERENCES dbo.ExpenseOwner(ExpenseOwnerId)

)


GO

CREATE NONCLUSTERED INDEX IDX_Expense_Classification
  ON dbo.Expense(ExpenseClassificationId ASC);

GO

CREATE NONCLUSTERED INDEX IDX_Expense_Owner
  ON dbo.Expense(ExpenseOwnerId ASC);
GO

 
 PRINT N'Create Income Classification'
 GO

 CREATE TABLE dbo.IncomeClassification
(
	IncomeClassificationId SMALLINT NOT NULL CONSTRAINT PK_IncomeClassification_Id PRIMARY KEY CLUSTERED,
	ClassificationName VARCHAR(50) NOT NULL,
	ClassificationDescription VARCHAR(100) NOT NULL
)

GO

PRINT N'Create Employer'
GO

CREATE TABLE dbo.Employer
(
	EmployerId SMALLINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Employer_Id PRIMARY KEY CLUSTERED,
	EmployerName VARCHAR(50) NOT NULL,
	EmployerDescription VARCHAR(100) NOT NULL
)

GO

PRINT N'Create Income'
GO


CREATE TABLE dbo.Income
(
	IncomeId INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Income_Id PRIMARY KEY CLUSTERED,
	IncomeClassificationId SMALLINT NOT NULL,
	EmployerId SMALLINT NOT NULL,
	BeforeDeductions DECIMAL(8,2) NOT NULL,
	AfterDeductions DECIMAL(8,2) NOT NULL,
    TransactionDate DATETIMEOFFSET(2) NOT NULL,
    ExpenseOwnerId SMALLINT NOT NULL,
	CONSTRAINT FK_Income_Classification FOREIGN KEY (IncomeClassificationId) REFERENCES dbo.IncomeClassification(IncomeClassificationId),
	CONSTRAINT FK_Income_Employer FOREIGN KEY (EmployerId) REFERENCES dbo.Employer(EmployerId),
    CONSTRAINT FK_Income_Owner FOREIGN KEY (ExpenseOwnerId) REFERENCES dbo.ExpenseOwner(ExpenseOwnerId)
)

GO


CREATE NONCLUSTERED INDEX IDX_Income_Income_Classification
  ON dbo.Income(IncomeClassificationId ASC);

GO

CREATE NONCLUSTERED INDEX IDX_Income_Employer
  ON dbo.Income(EmployerId ASC);
GO
	


CREATE NONCLUSTERED INDEX IDX_Income_Owner
  ON dbo.Income(ExpenseOwnerId ASC)
GO