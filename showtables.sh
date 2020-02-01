#!/usr/bin/bash
function checkDatabaseName() {
  if [ -z "$databaseName" ]; then
    echo "Enter database name: "
    read databaseName
    checkDatabaseName
    return
  fi
}

function checkTableName() {
  echo "Enter the name of table: "
  read tableName

  if test ! -f "databases/$databaseName/$tableName"; then
    echo "$tableName does not exist!"
    exit
  fi
}


databaseName=$1
checkDatabaseName
checkTableName
echo "Your Table"
cat databases/$databaseName/$tableName
