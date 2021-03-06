DECLARE @Name nvarchar(2550)
DECLARE Users_and_Logins CURSOR FOR

SELECT sp.name FROM sys.server_principals sp
INNER JOIN sys.database_principals dp ON sp.name = dp.name AND sp.[sid] <> dp.[sid] AND sp.type_desc <> 'SERVER_ROLE'

OPEN Users_and_Logins
	FETCH NEXT FROM Users_and_Logins INTO @Name
WHILE @@FETCH_STATUS = 0
    BEGIN
		
		exec sp_change_users_login @Action='update_one', @UserNamePattern=@Name, @LoginName=@Name; 

	FETCH NEXT FROM Users_and_Logins INTO @Name
	END
CLOSE Users_and_Logins
DEALLOCATE Users_and_Logins