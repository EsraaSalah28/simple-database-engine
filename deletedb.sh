#!/usr/bin/bash
function deleteDatabse() {
  echo "Enter the name of database that you want to delete: "
  read databaseName

  if [ -d "databases/$databaseName" ]; then
    rm -rf "databases/$databaseName"
  else
    echo "$databaseName does not exist!"
    deleteDatabse
    return
  fi
}

deleteDatabse
