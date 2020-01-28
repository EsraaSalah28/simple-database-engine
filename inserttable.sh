#!/usr/bin/bash

function split() {
  local string="$1"
  local delimiter="$2"
  if [ -n "$string" ]; then
    local part
    while read -d "$delimiter" part; do
      echo $part
    done <<<"$string"
    echo $part
  fi
}

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

databaseName=$1

checkDatabaseName

#============================================================
if [ -d "databases/$databaseName" ]; then
  checkTableName

  #  awk 'BEGIN{FS=":";} {i=1; while (i<=NF){print $i;i++}}' "databases/$databaseName/$tableName"

  declare -A array
  awk 'BEGIN{FS=":";} {i=1; while (i<=NF){$array[i]=$i;i++}}' "databases/$databaseName/$tableName"
  echo "${array[@]}"
  for i in "${array[@]}"; do
    echo $i
    # do whatever on $i
  done

#  output=$( sed -n 1p "databases/$databaseName/$tableName")
#  echo $output
#
#  split "$output" ":"

else
  echo "$databaseName does not exist!"
  exit
fi
