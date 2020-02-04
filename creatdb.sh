#!/usr/bin/bash

echo "Enter The Name of Database: "
read databaseName

if [ -d "databases/$databaseName" ]; then
  echo "database $databaseName Already Exists!"
  source main.sh
else
  mkdir -p "databases/${databaseName}"
  echo "database $databaseName created successfully!"
fi

printf "\n\n"
source editdatabase.sh "$databaseName"
