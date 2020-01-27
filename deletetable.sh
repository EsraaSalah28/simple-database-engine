#!/usr/bin/bash
function deleteTable() {
  echo "Enter the name of database: "
  read databaseName

  if [ -d "databases/$databaseName" ]; then
    echo "Enter the name of table: "
    read tableName

    if [ -f "databases/$databaseName/$tableName" ]; then
      rm -rf "databases/$databaseName/$tableName"
      echo "table $tableName deleted successfully"
      return
    else
      echo "table $tableName does not exists in database $databaseName"
      deleteTable
      return
    fi

  else
    echo "$databaseName does not exist!"
    deleteTable
    return
  fi
}

deleteTable
