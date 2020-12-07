#!/bin/bash
DIR=$(dirname "$0")
echo "Removing all old files. "
sudo rm -fR vendor web .editorconfig .gitattributes composer.lock sold-data config.zip
docker-compose down -v
docker-compose up -d --build
composer install
${DIR}/prepare.sh
${DIR}/install.sh
${DIR}/search.sh
