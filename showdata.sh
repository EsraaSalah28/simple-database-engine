#!/usr/bin/bash

source commonfunctions.sh
# ===========================================================================

databaseName=$1
checkDatabaseName
checkTableName

printTable ':' "$(cat "databases/$databaseName/$tableName")"
