#!/usr/bin/bash

echo "Enter The Name of Database: "
read databaseName

if [ -d "databases/$databaseName" ]; then
  echo "DB Already Exists"
  exit
else
  mkdir -p "databases/${databaseName}"
fi

source createtable.sh "${databaseName}"