#!/bin/bash
if [ $1 ]
then
docker exec -it drupal_$1_1 bash
fi
