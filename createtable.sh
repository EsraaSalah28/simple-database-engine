#!/usr/bin/bash
# f
function hi()
{
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
   echo $datatype $field >>mn
  
   

done
}
hi
echo enter the field that you want to be PK
   read pk
  if [ $pk == $field  ] 
   then
     prim='PK'
     newField="${field} ${prim}"
echo "${newField}"
sed -i "s/$field/$newField/g" mn
   
   fi
echo ==============================
awk 'BEGIN{FS="\t"; ORS="\t"} {print $1,$2}' mn