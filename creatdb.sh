#!/usr/bin/bash

echo "Enter The Name of Database: "
read databaseName

if [ -d "databases/$databaseName" ]; then
  echo "DB Already Exists"
else
  mkdir -p "databases/${databaseName}"
fi

source creattable.sh "${databaseName}"