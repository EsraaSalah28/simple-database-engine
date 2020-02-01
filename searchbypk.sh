#!/usr/bin/bash

source commonfunctions.sh
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

awk -v fieldValue="$fieldValue" -v indexOfPKField="$indexOfPKField" 'BEGIN{ FS=":";} {if(FNR!=1 && $indexOfPKField==fieldValue){ print $0; found=1;}else{found=0;} } END{ printf "found: "; print found; if(found==0){printf "No record found for value: "; printf fieldValue} }' "databases/$databaseName/$tableName"
