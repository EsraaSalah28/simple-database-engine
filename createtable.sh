#!/usr/bin/bash

source commonfunctions.sh
#============================================================

function dtype() {
  echo "Enter the datatype [ available types are (int) & (string) ]: "
  read datatype

  if [ "$datatype" == "string" ] || [ "$datatype" == "int" ] || [ "$datatype" == "STRING" ] || [ "$datatype" == "INT" ]; then
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

  if [ -z "$tableName" ]; then
    printf "Error: Table name can't be empty!\n"
    createTable databaseName
    return
  fi

  if [ -f "databases/$databaseName/$tableName" ]; then
    echo "Table with name $tableName already exits!"
    printf "\n\n"
    source editdatabase.sh "$databaseName"
    return
  fi

  echo "Enter the number of fields: "
  read num

  re='^[0-9]'
  if ! [[ $num =~ $re ]]; then
    echo "Error: Not a number, enter a number"
    createTable "$databaseName"
    return
  fi

  allfieldsAndDataTypes=()
  tableStrcuture=""

  for ((i = 1; i <= num; i++)); do
    echo "Enter your $i field: "
    read field

    dtype

    allfieldsAndDataTypes+=("$datatype $field")
  done

  primaryKey

  for ((i = 0; i < ${#allfieldsAndDataTypes[@]}; i++)); do
    if ! [[ "$i" == $((${#allfieldsAndDataTypes[@]} - 1)) ]]; then
      tableStrcuture+="${allfieldsAndDataTypes[i]}:"
    else
      tableStrcuture+="${allfieldsAndDataTypes[i]}"
    fi
  done

  echo "$tableStrcuture" >>"databases/$databaseName/$tableName"
  echo "=================================="
  printf "Created table:\n"
  printTable ':' "$(sed -n 1p "databases/$databaseName/$tableName")"
}
#============================================================

function primaryKey() {
  echo "Enter the field that you want to be PK: "
  read pk

  for ((i = 0; i < ${#allfieldsAndDataTypes[@]}; i++)); do
    fieldName=$(echo "${allfieldsAndDataTypes[i]}" | awk '{print $2;}')
    if [[ $fieldName == "$pk" ]]; then
      allfieldsAndDataTypes[i]=$(
        echo "${allfieldsAndDataTypes[i]}" | sed -e "s/${allfieldsAndDataTypes[i]}/${allfieldsAndDataTypes[i]} PK/g"
      )
      #      allfieldsAndDataTypes[i]=$(echo "${${allfieldsAndDataTypes[i]}//${allfieldsAndDataTypes[i]}/"${allfieldsAndDataTypes[i]} PK"}")
      return
    fi
  done

  echo "$pk is not a field in the table!"
  primaryKey
  return
}

#============================================================
#Start

databaseName=$1

checkDatabaseName

#============================================================
if [ -d "databases/$databaseName" ]; then
  createTable "$databaseName"
else
  echo "$databaseName does not exist!"
  exit
fi
#============================================================

printf "\n\n"
source editdatabase.sh "$databaseName"
