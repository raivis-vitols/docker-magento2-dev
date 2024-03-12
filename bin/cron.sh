#!/bin/bash

cd $(dirname $(dirname "$0"))

docker-compose exec -uroot php service cron $1
