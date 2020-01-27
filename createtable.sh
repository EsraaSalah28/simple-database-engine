#!/usr/bin/bash

#============================================================
function dtype() {
  echo "Enter the datatype: "
  read datatype

  if [ "$datatype" == "string" ] || [ "$datatype" == "int" ] || [ "$datatype" == "date" ] || [ "$datatype" == "char" ] || [ "$datatype" == "CHAR" ] || [ "$datatype" == "DATE" ] || [ "$datatype" == "STRING" ] || [ "$datatype" == "INT" ]; then
    #    echo "$datatype" $field >>$databaseName/$tableName
    return
  else
    echo "Invalid datatype!"
    dtype
    return
  fi
}
#============================================================

function createTable() {
  databaseName=$1

  echo "Enter the name of table: "
  read tableName

  if [ -f "databases/$databaseName/$tableName" ]; then
    echo "Table with name $tableName already exits!"
    createTable "$databaseName"
    return
  fi

  echo "Enter the number of fields: "
  read num

  re='^[0-9]'
  if ! [[ $num =~ $re ]]; then
    echo "Error: Not a number enter a number"
    createTable "$databaseName"
    return
  fi

  allfields=()

  for ((i = 1; i <= num; i++)); do
    echo "Enter your $i field: "
    read field

    allfields+=("$field")

    dtype
    echo "$datatype $field" >>"databases/$databaseName/$tableName"

  done

  primaryKey
}
#============================================================

function primaryKey() {
  echo "Enter the field that you want to be PK: "
  read pk

  for t in "${allfields[@]}"; do
    echo "t: $t"
    echo "pk: $pk"
    if [ "$t" = "$pk" ]; then
      newField="$pk PK"
      sed -i "s/$pk/$newField/g" "databases/$databaseName/$tableName"
      break
    else
      echo "$pk is not a field in the table!"
      primaryKey
      return
    fi
  done
}

#============================================================
#Start

databaseName=$1
if [ -z "$databaseName" ]; then
  echo "Enter database name: "
  read databaseName
fi

#============================================================
if [ -d "databases/$databaseName" ]; then
  createTable "$databaseName"
else
  echo "$databaseName does not exist!"
  exit
fi
#============================================================

echo "=================================="

awk 'BEGIN{FS="\t"; ORS="\t"} {print $1,$2}' "databases/$databaseName/$tableName"
printf "\n"
