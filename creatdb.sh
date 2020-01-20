#!/usr/bin/bash
function choose()
{
    select choice in "Create Table" " Delete Table" " Modify Table" " Insert Data" " List Tables" "Delete Record"
do

case $REPLY in 

1)
source  ~/Desktop/bashProject/createtable.sh 
break ;;
2)
source  ~/Desktop/bashProject/deletetable.sh
break;;
3)
source  ~/Desktop/bashProject/modifytable.sh
break;;
4)
source  ~/Desktop/bashProject/inserttable.sh
break;;
5)
source  ~/Desktop/bashProject/listdata.sh
break;;
  
esac
done
 

}
echo "Enter The Name of Database"
read databaseName
if [ -d $databaseName ]
then
   echo "DB Already Exists"    
else
  mkdir ~/Desktop/bashProject/$databaseName
  choose



fi

