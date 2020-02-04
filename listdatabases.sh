#!/usr/bin/bash

if [ -d "databases" ]; then
  ls "databases"
else
  echo "No databases found!"
fi

printf "\n\n"
source main.sh