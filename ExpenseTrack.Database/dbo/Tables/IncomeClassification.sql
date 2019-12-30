
CREATE TABLE dbo.IncomeClassification
(
	IncomeClassificationId SMALLINT NOT NULL CONSTRAINT PK_IncomeClassification_Id PRIMARY KEY CLUSTERED,
	ClassificationName VARCHAR(50) NOT NULL,
	ClassificationDescription VARCHAR(100) NOT NULL
)