#!/usr/bin/bash

if [ -d "databases" ]; then
  ls "databases"
else
  echo "No databases exists"
fi

source main.sh