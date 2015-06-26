#!/bin/bash

SHA1=$1

if [ -z "$SHA1" ]
  then
    echo "Error: no version supplied"
    exit 1;
fi

docker info
docker build -t benearlam/unconference_web:$SHA1 .
