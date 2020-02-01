#!/usr/bin/bash
# shellcheck disable=SC2162

source commonfunctions.sh
# ===========================================================================

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

#This is a var that will hold all of the values to be inserted into table
record=""

# this is used to loop on the array
index=0
for (( ; index < ${#array[@]}; ++index)); do
  #parse field Name and Type using awk
  fieldName=$(echo "${array[index]}" | awk '{print $2;}')
  fieldType=$(echo "${array[index]}" | awk '{print $1;}')

  # asking user to enter the value
  echo "Enter value of $fieldName: "
  read fieldValue

  # checking if entered value match the columns (field) type
  # if not then re-ask user to enter value again by re-looping on the same loop!
  result=$(checkIfValueMatchesDataType "$fieldValue" "$fieldType")
  if [[ "$result" == 0 ]]; then
    echo "Error: Entred value $fieldValue does not match with field type $fieldType"
    index=$((index - 1))
    continue
  fi

  # check if this is a pk field then check value if exists before
  # if it do exists before the re-ask user to enter val again
  if [[ ${array[index]} == *"PK"* ]]; then

    # read all ids from table and save them in string using awk
    ids=$(awk -v indexOfPKField="$((index + 1))" 'BEGIN{ FS=":"; } { if(FNR!=1){ printf $indexOfPKField; printf ":"; } }' "databases/$databaseName/$tableName")

    #sperate the read string then loop on it
    OIFS=$IFS # saving old $IFS in OIFS
    IFS=':'   # doing speration and save values in array
    flag=0    #flag used to break outer-loop
    for id in $ids; do
      if [[ "$id" == "$fieldValue" ]]; then
        echo "ERROR: $fieldName is a PrimaryKey field, The entred value $fieldValue already exists!"
        flag=1
        break
      fi
    done
    IFS=$OIFS # restore old $IFS in OIFS

    # this means the entered value exists before
    # so re-loop in order to re-ask user to enter the value again
    if [[ $flag == 1 ]]; then
      index=$((index - 1))
      continue
    fi
  fi

  # append value on values that will be written in file
  if [[ $index < $((${#array[@]} - 1)) ]]; then
    record+="$fieldValue:"
  else
    record+="$fieldValue"
  fi
done

# finaly write the values in the file
echo "$record" >>"databases/$databaseName/$tableName"
echo "Inserted record:"
echo "$record"
