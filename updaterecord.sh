#!/usr/bin/bash
# shellcheck disable=SC2162

source commonfunctions.sh
#============================================================

function checkIfValueMatchesDataType() {
  local inputValue=$1
  local dataType=$2

  if [[ "$dataType" == "int" ]] || [[ "$dataType" == "INT" ]]; then
    if [[ "$inputValue" =~ ^[0-9]+$ ]]; then
      echo 1
    else
      echo 0
    fi
  fi

}

function readPkValue() {
  echo "Enter PK field value: "
  read fieldValue

  if [ -z "$fieldValue" ]; then
    readPkValue
    return
  fi

  indexOfPKField=-1
  for ((i = 0; i < ${#array[@]}; ++i)); do
    if [[ ${array[i]} == *"PK"* ]]; then
      indexOfPKField=$((i + 1))
      break
    fi
  done

  # get number of record to be deleted
  lineNum=$(
    awk -v fieldValue="$fieldValue" -v indexOfPKField="$indexOfPKField" 'BEGIN{ FS=":"; } { if(FNR!=1 && $indexOfPKField==fieldValue){ print FNR;} }' "databases/$databaseName/$tableName"
  )

  if [ -z "$lineNum" ]; then
    echo "Error: PK field value $fieldValue does not exists!"
    readPkValue
    return
  fi

  oldRecord=$(awk -v n="$lineNum" 'FNR==n {print $0}' "databases/$databaseName/$tableName")
  printTable ':' "$(sed -n 1p "databases/$databaseName/$tableName")\n$oldRecord"

  OIFS=$IFS # saving old $IFS in OIFS
  IFS=':'   # doing speration and save values in array
  read -r -a recordArray <<<"$oldRecord"
  IFS=$OIFS # restore old $IFS in OIFS
}

function enterValueToUpdate() {
  echo "Enter new $1 value: "
  read fieldValue

  if [ -z "$fieldValue" ]; then
    enterValueToUpdate
    return
  fi
}

#============================================================

databaseName=$1   #assign name of db from pararmters passed to sh file

checkDatabaseName #calling the check db function

# check if DB does not exists!
if ! [[ -d "databases/$databaseName" ]]; then
  echo "$databaseName does not exist!"
  exit
fi

checkTableName #calling the check table function

OIFS=$IFS # saving old $IFS in OIFS
IFS=':'   # doing speration and save values in array
read -r -a array <<<"$(sed -n 1p "databases/$databaseName/$tableName")"
IFS=$OIFS # restore old $IFS in OIFS

# ask user for pk value of record that he wish to update
# and if not exists then re-ask him
readPkValue

# this is used to loop on the array
index=0
for (( ; index < ${#array[@]}; ++index)); do
  #parse field Name and Type using awk
  fieldName=$(echo "${array[index]}" | awk '{print $2;}')
  fieldType=$(echo "${array[index]}" | awk '{print $1;}')

  # check if this is a pk field then check value if exists before
  # if it do exists before the re-ask user to enter val again
  if [[ ${array[index]} == *"PK"* ]]; then
    continue
  fi

  # asking user to enter the value
  echo "Do you want to update value of $fieldName: [y/n]"
  read yesOrNo

  # check for user's answer
  if ! [[ "$yesOrNo" == "y" ]] && ! [[ "$yesOrNo" == "yes" ]] && ! [[ "$yesOrNo" == "Y" ]] && ! [[ "$yesOrNo" == "YES" ]]; then
    continue
  fi

  # asking user to enter the new value
  enterValueToUpdate "$fieldName"

  # checking if entered value match the columns (field) type
  # if not then re-ask user to enter value again by re-looping on the same loop!
  result=$(checkIfValueMatchesDataType "$fieldValue" "$fieldType")
  if [[ "$result" == 0 ]]; then
    echo "Error: Entred value $fieldValue does not match with field type $fieldType"
    index=$((index - 1))
    continue
  fi

  # update in the recordArray
  recordArray[index]=$fieldValue
done

# create new record string to be updated in file
for ((i = 0; i < ${#recordArray[@]}; i++)); do
  if [[ $i < $((${#recordArray[@]} - 1)) ]]; then
    newRecord+="${recordArray[i]}:"
  else
    newRecord+="${recordArray[i]}"
  fi
done

# finaly write the values in the file
awk -v newRecord="$newRecord" -v n="$lineNum" '{if(FNR!=n){print $0}else{print newRecord}}' "databases/$databaseName/$tableName" >"databases/$databaseName/$tableName.tmp"
mv "databases/$databaseName/$tableName.tmp" "databases/$databaseName/$tableName"

# display updated data to user
echo "Updated record:"
printTable ':' "$(sed -n 1p "databases/$databaseName/$tableName")\n$newRecord"


