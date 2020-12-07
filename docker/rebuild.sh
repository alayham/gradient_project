#!/bin/bash
DIR=$(dirname "$0")
sudo rm -fR vendor web .editorconfig .gitattributes composer.lock sold-data config.zip
mkdir -p config/sync
composer install
docker-compose down -v
docker-compose up -d --build
${DIR}/prepare.sh
${DIR}/install.sh
${DIR}/search.sh
