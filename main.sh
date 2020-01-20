#!/usr/bin/bash

select choice in "Create DB" "Create Table" " Delete DB" " Delete Table" " Modify Table" " Insert Data" " List DB and Tables" "Delete Record"
do

case $REPLY in 
1) 
source  ~/Desktop/bashProject/creatdb.sh 
break
;;

2)
source  ~/Desktop/bashProject/createtable.sh 
break ;;
3)
source  ~/Desktop/bashProject/deletedb.sh 
break ;;
4)
source  ~/Desktop/bashProject/deletetable.sh
break;;
5)
source  ~/Desktop/bashProject/modifytable.sh
break;;
6)
source  ~/Desktop/bashProject/inserttable.sh
break;;
7)
source  ~/Desktop/bashProject/listdata.sh
break;;
8)
source  ~/Desktop/bashProject/deleterecord.sh
break;;
  
esac
done
            
