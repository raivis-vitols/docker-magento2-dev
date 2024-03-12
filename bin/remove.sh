#!/bin/bash

cd $(dirname $(dirname "$0"))

read -p "Are you sure (y/n)? "
if [[ $REPLY =~ ^[Yy]$ ]]
then
    rm -rf .env \
        html/ \
        data/ \
        env/certificates/ \
        env/composer/auth.json
fi
