#!/usr/bin/bash
function choose()
{
    select choice in "Create Table" " Delete Table" " Modify Table" " Insert Data" " List Tables" "Delete Record"
do

case $REPLY in 

1)
source createtable.sh 
break ;;
2)
source  deletetable.sh
break;;
3)
source  modifytable.sh
break;;
4)
source  inserttable.sh
break;;
5)
source  listdata.sh
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
   export $databaseName
  source createtable.sh 
 
  choose



fi

