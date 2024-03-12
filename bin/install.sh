#!/bin/bash

cd $(dirname $(dirname "$0"))

source .env
MAGENTO_REPOSITORY_URL="https://repo.magento.com/"
MAGENTO_DEFAULT_EDITION="magento/project-community-edition"

echo -e "\nEnter Base URL with schema (ex. https://local.magento.com):"
read BASE_URL

echo -e "\nEnter MySQL database name (will be created unless it exists):"
read MYSQL_DB_NAME

echo -e "\nEnter Magento edition to install [default: $MAGENTO_DEFAULT_EDITION]:"
read MAGENTO_EDITION
MAGENTO_EDITION=${MAGENTO_EDITION:-$MAGENTO_DEFAULT_EDITION}

docker-compose exec mysql mysql -uroot -p$MYSQL_PASSWORD -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DB_NAME}"
docker-compose exec php composer create-project --repository-url=$MAGENTO_REPOSITORY_URL $MAGENTO_EDITION .
docker-compose exec php bin/magento setup:install \
    --base-url=$BASE_URL \
    --use-rewrites=1 \
    --db-host=mysql \
    --db-user=root \
    --db-name=$MYSQL_DB_NAME \
    --db-password=$MYSQL_PASSWORD \
    --search-engine=opensearch \
    --opensearch-host=opensearch \
    --opensearch-port=9200 \
    --backend-frontname=admin \
    --session-save=redis \
    --session-save-redis-host=redis \
    --session-save-redis-port=6379 \
    --session-save-redis-password=$REDIS_PASSWORD \
    --session-save-redis-db=0 \
    --cache-backend=redis \
    --cache-backend-redis-server=redis \
    --cache-backend-redis-port=6379 \
    --cache-backend-redis-password=$REDIS_PASSWORD \
    --cache-backend-redis-db=1 \
    --page-cache=redis \
    --page-cache-redis-server=redis \
    --page-cache-redis-port=6379 \
    --page-cache-redis-password=$REDIS_PASSWORD \
    --page-cache-redis-db=2 \
    --lock-provider=file \
    --lock-file-path=/var/www/html/var/locks \
    --amqp-host=rabbitmq \
    --amqp-port=5672 \
    --amqp-user=guest \
    --amqp-password=guest
