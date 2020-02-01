#!/usr/bin/bash
function delete() {

  while [ ! -d "databases/$deletedDb" ]; do
    echo Enter the name of DB you want to delete
    read deletedDb
    if [ -d "$deletedDb" ]; then
      rm -r "databases/$deletedDb"
      break
    else
      echo "There is no such a database rewrite it again"
    fi
  done
}

echo "Enter the name of DB you want to delete"
read deletedDb
if [ -d "$deletedDb" ]; then
  rm -r "databases/$deletedDb"
else
  echo "There is no such a database rewrite it again"
  delete
fi
