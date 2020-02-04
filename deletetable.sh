#!/usr/bin/bash

source commonfunctions.sh
# ===========================================================================

databaseName=$1   #assign name of db from pararmters passed to sh file

checkDatabaseName #calling the check db function

if [ -d "databases/$databaseName" ]; then
  echo "Enter the name of table: "
  read tableName

  if [ -f "databases/$databaseName/$tableName" ]; then
    rm -rf "databases/$databaseName/$tableName"
    echo "table $tableName deleted successfully"
  else
    echo "table $tableName does not exists in database $databaseName"
  fi

else
  echo "$databaseName does not exist!"
fi

printf "\n\n"
source editdatabase.sh "$databaseName"
