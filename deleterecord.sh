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

# ===========================================================================

databaseName=$1   #assign name of db from pararmters passed to sh file

checkDatabaseName #calling the check db function

# check if DB does not exists!
if ! [[ -d "databases/$databaseName" ]]; then
  echo "$databaseName does not exist!"
  exit
fi

checkTableName #calling the check table function

echo "PK field value: "
read fieldValue

OIFS=$IFS # saving old $IFS in OIFS
IFS=':'   # doing speration and save values in array
read -r -a array <<<"$(sed -n 1p "databases/$databaseName/$tableName")"
IFS=$OIFS # restore old $IFS in OIFS

indexOfPKField=-1
for (( ; index < ${#array[@]}; ++index)); do
  if [[ ${array[index]} == *"PK"* ]]; then
    indexOfPKField=$((index + 1))
  fi
done

# get number of record to be deleted
lineNum=$(
  awk -v fieldValue="$fieldValue" -v indexOfPKField="$indexOfPKField" 'BEGIN{ FS=":"; } { if(NR!=1 && $indexOfPKField==fieldValue){ print NR;} }' "databases/$databaseName/$tableName"
)

# echo the record to be deleted
echo "delete record: "
awk -v n="$lineNum" 'NR==n {print $0}' "databases/$databaseName/$tableName"

# do deletion
awk -v n="$lineNum" 'NR==n {next} {print}' "databases/$databaseName/$tableName" >"databases/$databaseName/$tableName.tmp"
mv "databases/$databaseName/$tableName.tmp" "databases/$databaseName/$tableName"
