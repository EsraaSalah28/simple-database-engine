#!/usr/bin/bash
function dtype()
{
    echo enter the datatype 
  read datatype 
  if [ $datatype == "string"  ] || [ $datatype == "int"  ]  || [ $datatype == "date"   ] || [ $datatype == "char" ] || [ $datatype == "CHAR"   ] || [ $datatype == "DATE"   ] || [ $datatype == "STRING"  ] || [ $datatype == "INT"  ]
  then
   echo $datatype $field >> $databaseName/$tableName
   fi

}
function createTable()
{
echo enter the name of table 
read tableName
 mkdir $databaseName

echo enter the number of fields 
read num
re='^[0-9]'
if ! [[ $num =~ $re ]] ; then
   echo "error: Not a number enter a number"
   read num 
fi
typeset -i arr[$num]

for ((i=1;i<=num;i++))
do
echo enter your $i field
read field
 arr[i]=$field 
  echo enter the datatype 
  read datatype 
  if [ $datatype == "string"  ] || [ $datatype == "int"  ]  || [ $datatype == "date"   ] || [ $datatype == "char" ] || [ $datatype == "CHAR"   ] || [ $datatype == "DATE"   ] || [ $datatype == "STRING"  ] || [ $datatype == "INT"  ]
  then
   echo $datatype $field >> $databaseName/$tableName
   else
   echo Inavalide datatype please again
   dtype
   fi
  
   

done


}
function primaryKey()
{
prim='PK'
     newField="${field} ${prim}"
sed -i "s/$field/$newField/g" $databaseName/$tableName

}
createTable
echo enter the field that you want to be PK
   read pk
  if [ $pk == $field  ] 
   then
   primaryKey
#      prim='PK'
#      newField="${field} ${prim}"
# sed -i "s/$field/$newField/g" $databaseName/$tableName
else
echo this fiels doesnot exist please write it again 
  read pk 
  primaryKey
   
   fi
echo ==============================
awk 'BEGIN{FS="\t"; ORS="\t"} {print $1,$2}' $databaseName/$tableName
printf "\n"