#!/usr/bin/bash

select choice in "Create DB"  " Delete DB"  " List DBs" " Exit"
do

case $REPLY in 
1) 
source  creatdb.sh 
break
;;

2)
source  deletedb.sh 
break ;;
3)
source  listdata.sh
break;;
4)
  exit
break;;

  
esac
done
            
