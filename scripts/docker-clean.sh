#!/bin/bash
while getopts “riv” OPTION
do
     case $OPTION in
         r)
             docker-compose stop
             docker-compose rm
             ;;
         i)
             docker rmi $(docker images -f "dangling=true" -q)
             ;;
         v)
             docker volume rm $(docker volume ls -f "dangling=true")
             ;;
     esac
done
