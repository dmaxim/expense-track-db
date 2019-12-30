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


