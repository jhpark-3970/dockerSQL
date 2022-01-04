Container for SQLServer19 on Ubuntu20.04

# Non root user container for SQL Server
- root
- mssql

# Install
docker build -t sqlsrv .
docker run -e "ACCEPT_EULA=Y" -e "Testing1122" -p 1433:1433 --name sql1 -h sql1 -d sqlsrv

# Other way to make sql server container based on Ubuntu
# https://dbafromthecold.com/2020/07/17/sql-server-and-docker-compose/

# Change SA Password
docker exec -it sql1 /opt/mssql-tools/bin/sqlcmd `
   -S localhost -U SA -P "<YourStrong@Passw0rd>" `
   -Q "ALTER LOGIN SA WITH PASSWORD='<YourNewStrong@Passw0rd>'"

# bash shell and sqlcmd
docker exec -it sql1 "bash"
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "<YourNewStrong@Passw0rd>"


# backup
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "Testing1122"
1> RESTORE DATABASE OD3DSDB_In2Guide
2> FROM DISK = '/var/opt/mssql/backup/OD3DSDB.BAK'
3> WITH MOVE 'OD3DSDB_In2Guide' TO '/var/opt/mssql/data/OD3DSDB.mdf',
4> MOVE 'OD3DSDB_In2Guide_log' TO '/var/opt/mssql/data/OD3DSDB.ldf'
5> go