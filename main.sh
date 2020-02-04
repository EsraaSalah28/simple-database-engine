#!/usr/bin/bash

function showMainMenuSelections() {
  select choice in "Create database" "Delete database" "List databases" "Edit database" "List tables" "Show data" "Search by PK" "Exit"; do

    case $REPLY in
    1)
      source creatdb.sh
      break
      ;;
    2)
      source deletedb.sh
      break
      ;;
    3)
      source listdatabases.sh
      break
      ;;
    4)
      source editdatabase.sh
      break
      ;;
    5)
      source listtables.sh
      break
      ;;
    6)
      source showdata.sh
      break
      ;;
    7)
      source searchbypk.sh
      break
      ;;
    8)
      echo "Bye!"
      exit
      ;;
    esac

  done
}

showMainMenuSelections
