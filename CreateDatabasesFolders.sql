DECLARE @command varchar(8000)

SELECT @command = 'IF ''?'' NOT IN (''master'', ''msdb'', ''tempdb'', ''model'')
BEGIN USE [?] EXEC(''
DECLARE @DataPath nvarchar(500)
DECLARE @DirTree TABLE (subdirectory nvarchar(255), depth INT)
SELECT @DataPath = ''''\\srv-bkp07.ulf.local\Backup_UAH$\Daily\Srv-db102\'''' + ''''?''''
INSERT INTO @DirTree(subdirectory, depth)
EXEC master.sys.xp_dirtree ''''\\srv-bkp07.ulf.local\Backup_UAH$\Daily\Srv-db102\''''
IF NOT EXISTS (SELECT 1 FROM @DirTree WHERE subdirectory = ''''?'''')
EXEC master.dbo.xp_create_subdir @DataPath
'') END'
EXEC sp_MSforeachdb @command

--EXEC master.dbo.xp_create_subdir @DataPath