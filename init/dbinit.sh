#!/usr/bin/env bash
set -e

# pick sqlcmd path dynamically
if [ -x /opt/mssql-tools18/bin/sqlcmd ]; then
  SQLCMD=/opt/mssql-tools18/bin/sqlcmd
elif [ -x /opt/mssql-tools/bin/sqlcmd ]; then
  SQLCMD=/opt/mssql-tools/bin/sqlcmd
else
  echo "❌ sqlcmd not found in /opt/mssql-tools*/bin"
  ls -al /opt || true
  exit 1
fi

# wait for SQL Server (service name 'mssql' in docker-compose network)
for i in {1..60}; do
  $SQLCMD -S mssql -U sa -P "Str0ng!Passw0rd" -Q "SELECT 1" >/dev/null 2>&1 && break
  sleep 2
done

# restore Northwind if missing
$SQLCMD -S mssql -U sa -P "Str0ng!Passw0rd" -Q "
IF DB_ID(N'Northwind') IS NULL
BEGIN
  PRINT 'Restoring Northwind...';
  RESTORE DATABASE [Northwind]
  FROM DISK = N'/var/opt/mssql/backup/Northwind.bak'
  WITH MOVE N'Northwind'     TO N'/var/opt/mssql/data/Northwind.mdf',
       MOVE N'Northwind_log' TO N'/var/opt/mssql/data/Northwind_log.ldf',
       REPLACE;
  PRINT 'Restore done.';
END
ELSE
BEGIN
  PRINT 'Northwind already exists. Skipping restore.';
END"
