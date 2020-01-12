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
