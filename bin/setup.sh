#!/bin/bash

FILE_CERT="env/certificates/certificate.pem"
FILE_CERT_KEY="env/certificates/certificate-key.pem"

FILE_ENV=".env"
FILE_COMPOSER_AUTH="env/composer/auth.json"
FILE_COMPOSER_AUTH_SAMPLE="env/composer/auth.json.sample"

cd $(dirname $(dirname "$0"))
mkdir -p html \
    data/redis \
    data/mysql \
    data/sql-dumps \
    data/opensearch \
    env/certificates

if [ ! -f "$FILE_CERT"  ] ||  [ ! -f "$FILE_CERT_KEY" ]
then
    echo -e "\nEnter URL without schema (ex. local.magento.com)"
    read DOMAIN
    mkcert -cert-file $FILE_CERT -key-file $FILE_CERT_KEY $DOMAIN
fi

if [ ! -f "$FILE_COMPOSER_AUTH"  ]
then
    echo "Composer: Enter repo.magento.com username (public access key):"
    read AUTH_KEY_PUBLIC

    echo -e "\nComposer: Enter repo.magento.com password (private access key):"
    read AUTH_KEY_PRIVATE

    cp $FILE_COMPOSER_AUTH_SAMPLE $FILE_COMPOSER_AUTH
    sed -i "s/#username#/$AUTH_KEY_PUBLIC/g" $FILE_COMPOSER_AUTH
    sed -i "s/#password#/$AUTH_KEY_PRIVATE/g" $FILE_COMPOSER_AUTH
fi

if [ ! -f "$FILE_ENV"  ]
then
    echo -e "\nMySQL: Enter MySQL password:"
    read MYSQL_PASSWORD

    echo -e "\nRedis: Enter Redis password:"
    read REDIS_PASSWORD

    echo "MYSQL_PASSWORD=$MYSQL_PASSWORD" >> $FILE_ENV
    echo "REDIS_PASSWORD=$REDIS_PASSWORD" >> $FILE_ENV
fi
