#!/usr/bin/bash

function listTables() {
  echo "Enter Databasename: "
  read databaseName

  if [ -d "databases/$databaseName" ]; then
    files=$(ls -1 "databases/$databaseName" | wc -l)

    if [ "$files" -gt 0 ]; then
      echo "database $databaseName has tables:"
      ls "databases/$databaseName"
    else
      echo "$databaseName has no tables!"
    fi

  else
    echo "$databaseName does not exist!"
    return
  fi

}

listTables
