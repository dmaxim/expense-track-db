USE ExpenseTrack
GO

PRINT N'Creating Expense Classifications'
GO

SET IDENTITY_INSERT dbo.ExpenseClassification ON

GO

INSERT INTO dbo.ExpenseClassification
(ExpenseClassificationId, ClassificationName)
VALUES
(1, 'Airfare')

INSERT INTO dbo.ExpenseClassification
(ExpenseClassificationId, ClassificationName)
VALUES
(2, 'Hotel')

INSERT INTO dbo.ExpenseClassification
(ExpenseClassificationId, ClassificationName)
VALUES
(3, 'Car Rental')

INSERT INTO dbo.ExpenseClassification
(ExpenseClassificationId, ClassificationName)
VALUES
(4, 'Supplies')


INSERT INTO dbo.ExpenseClassification
(ExpenseClassificationId, ClassificationName)
VALUES
(5, 'Food')

INSERT INTO dbo.ExpenseClassification
(ExpenseClassificationId, ClassificationName)
VALUES
(6, 'Training')

INSERT INTO dbo.ExpenseClassification
(ExpenseClassificationId, ClassificationName)
VALUES
(7, 'Infrastructure Hosting')



GO

SET IDENTITY_INSERT dbo.ExpenseClassification OFF

GO

PRINT 'Creating Expense Owners'
GO

INSERT INTO dbo.ExpenseOwner
(OwnerUserId, FirstName, LastName)
VALUES
('dmaxim@mxinformatics.com', 'Dan', 'Maxim')

GO

PRINT N'Creating Income Classification'


INSERT INTO dbo.IncomeClassification
(IncomeClassificationId, ClassificationName, ClassificationDescription)
VALUES
(1, 'W2', 'W2')

INSERT INTO dbo.IncomeClassification
(IncomeClassificationId, ClassificationName, ClassificationDescription)
VALUES
(2, '1099', '1099')

GO

PRINT N'Creating Employers'
GO

SET IDENTITY_INSERT dbo.Employer ON
GO

INSERT INTO dbo.Employer
(EmployerId, EmployerName, EmployerDescription)
VALUES
(1, 'Atlas Coast', 'Atlas Coast')

INSERT INTO dbo.Employer
(EmployerId, EmployerName, EmployerDescription)
VALUES
(2, 'MxInformatics', 'MxInformatics')

INSERT INTO dbo.Employer
(EmployerId, EmployerName, EmployerDescription)
VALUES
(3, 'T4S Partners', 'T4S Partners')


SET IDENTITY_INSERT dbo.Employer OFF
GO

