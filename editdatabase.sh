#!/usr/bin/bash

function showEditDatabaseSelections() {
  select choice in "Create table" "Delete table" "Modify table" "Show tables" "Insert record" "Delete record" "Update record" "Main" "Exit"; do
    case $REPLY in

    1)
      source createtable.sh "$1"
      break
      ;;
    2)
      source deletetable.sh "$1"
      break
      ;;
    3)
      source modifytable.sh "$1"
      break
      ;;
    4)
      source listtables.sh "$1"
      break
      ;;
    5)
      source insertrecord.sh "$1"
      break
      ;;
    6)
      source deleterecord.sh "$1"
      break
      ;;
    7)
      source updaterecord.sh "$1"
      break
      ;;
    8)
      source main.sh
      break
      ;;

    9)
      exit
      ;;
    esac
  done

}

databaseName=$1
if [ -z "$databaseName" ]; then
  echo "Enter database name: "
  read databaseName
fi

if [ -d "databases/$databaseName" ]; then
  showEditDatabaseSelections "$databaseName"
else
  echo "Database $databaseName does not exists -> exitting"
  exit
fi
