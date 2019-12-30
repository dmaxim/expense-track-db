CREATE TABLE dbo.ExpenseClassification
(
	ExpenseClassificationId TINYINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Expense_Classification_Id PRIMARY KEY CLUSTERED,
	ClassificationName varchar(100) NOT NULL
)


GO

