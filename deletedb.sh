#!/usr/bin/bash
echo "Enter the name of Database you want to delete"
read deletedDb

if [ -d "databases/$deletedDb" ]; then
  rm -r "databases/$deletedDb"
  echo "$deletedDb deleted successfully!"
else
  echo "$deletedDb does not exists!"
fi

printf "\n\n"
source main.sh
