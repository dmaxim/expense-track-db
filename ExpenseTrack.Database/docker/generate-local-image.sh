#!/bin/bash

SA_PASSWORD="aXygpR312feffflxgh"
APP_USER_PASSWORD="somepass#xYGl"

echo "Building Image"

docker build -t mxinfo.expensetrack.dbtemp:latest .

echo "Running Image"

docker run -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=$SA_PASSWORD" -p 1934:1433 --name mxinfo.expensetrack.temp -d mxinfo.expensetrack.dbtemp:latest

echo "Initializing Database"

docker exec mxinfo.expensetrack.temp sh -c "/opt/scripts/initialize.sh '$APP_USER_PASSWORD'"

echo "Generating Final Image"

docker commit mxinfo.expensetrack.temp dmaxim/mxinfo.expensetrack.database:latest

echo "Tear down intermediate containers"

docker stop mxinfo.expensetrack.temp

docker rm mxinfo.expensetrack.temp



