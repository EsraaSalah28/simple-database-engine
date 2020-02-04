#!/usr/bin/bash

source commonfunctions.sh
# ===========================================================================

databaseName=$1
checkDatabaseName
checkTableName

printf "\n\n"

printTable ':' "$(cat "databases/$databaseName/$tableName")"

printf "\n\n"
source main.sh