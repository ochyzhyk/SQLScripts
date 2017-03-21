DECLARE @DirTree TABLE (subdirectory nvarchar(255), depth INT)

INSERT INTO @DirTree(subdirectory, depth)
EXEC master.sys.xp_dirtree '\\srv-bkp07.ulf.local\Backup_UAH$\Daily\Srv-db102\'
SELECT subdirectory FROM @DirTree
SELECT * FROM master.dbo.sysdatabases