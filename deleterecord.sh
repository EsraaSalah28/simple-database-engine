#!/usr/bin/bash

source commonfunctions.sh
# ===========================================================================

function readPkValue() {
  echo "Enter PK field value: "
  read fieldValue

  if [ -z "$fieldValue" ]; then
    readPkValue
    return
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

readPkValue

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
  awk -v fieldValue="$fieldValue" -v indexOfPKField="$indexOfPKField" 'BEGIN{ FS=":"; } { if(FNR!=1 && $indexOfPKField==fieldValue){ print FNR;} }' "databases/$databaseName/$tableName"
)

# echo the record to be deleted
echo "delete record: "
awk -v n="$lineNum" 'FNR==n {print $0}' "databases/$databaseName/$tableName"

# do deletion
awk -v n="$lineNum" 'FNR==n {next} {print}' "databases/$databaseName/$tableName" >"databases/$databaseName/$tableName.tmp"
mv "databases/$databaseName/$tableName.tmp" "databases/$databaseName/$tableName"


printf "\n\n"
source editdatabase.sh "$databaseName"