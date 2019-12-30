#!/bin/bash

appPasswordArg=$1

/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P $SA_PASSWORD -i ./initialize.sql -o output.txt

/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P $SA_PASSWORD -i ./createDatabase.sql -o createoutput.txt

echo :setvar appPassword $appPasswordArg > initializeUsers.sql

cat initializeUsersTemplate.sql >> initializeUsers.sql

/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P $SA_PASSWORD -i ./initializeUsers.sql -o useroutput.txt 

/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P $SA_PASSWORD -i ./initializeData.sql -o dataoutput.txt



