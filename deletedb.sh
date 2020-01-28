#!/usr/bin/bash
function delete() {
  isDeleted=false
  while [ ! -d $deletedDb ]; do
    echo Enter the name of DB you want to delete
    read deletedDb
    if [ -d $deletedDb ]; then
      isDeleted=true
      rm -r $deletedDb
      break
    else
      echo There is no such a database rewrite it again

    fi
  done
}
echo Enter the name of DB you want to delete
read deletedDb
if [ -d $deletedDb ]; then
  rm -r $deletedDb
else
  echo There is no such a database rewrite it again
  delete
fi
