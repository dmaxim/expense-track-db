
GO
USE MASTER
GO

CREATE LOGIN expense_app WITH PASSWORD = '$(appPassword)';

GO

CREATE USER expense_app FOR LOGIN expense_app WITH DEFAULT_SCHEMA = [dbo]

GO

USE ExpenseTrack
GO

CREATE USER expense_app FOR LOGIN expense_app WITH DEFAULT_SCHEMA = [dbo]

GO

CREATE ROLE ExpenseTrackApplicationRole AUTHORIZATION [dbo]

GO


GRANT 
	DELETE, 
	EXECUTE, 
	INSERT, 
	SELECT, 
	UPDATE
ON SCHEMA :: dbo
	TO ExpenseTrackApplicationRole
GO

EXEC sp_addrolemember 'ExpenseTrackApplicationRole', 'expense_app';

GO
