#!/bin/bash
docker-compose stop
docker-compose rm

while getopts “iv” OPTION
do
     case $OPTION in
         i)
             docker rmi $(docker images -f "dangling=true" -q)
             ;;
         v)
             docker volume rm $(docker volume ls -f "dangling=true")
             ;;
     esac
done
