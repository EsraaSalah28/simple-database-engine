#!/usr/bin/bash
function createTable()
{
echo enter the name of table 
read tableName
echo enter the number of fields 
read num
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
   echo $datatype $field >> $tableName
   else
   echo Inavalide datatype please enter again
   read $datatype
   fi
  
   

done
}
createTable
echo enter the field that you want to be PK
   read pk
  if [ $pk == $field  ] 
   then
     prim='PK'
     newField="${field} ${prim}"
echo "${newField}"
sed -i "s/$field/$newField/g" $tableName
   
   fi
echo ==============================
awk 'BEGIN{FS="\t"; ORS="\t"} {print $1,$2}' $tableName