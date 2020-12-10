ECHO OFF
docker-compose down -v
docker-compose up -d --build
docker-compose run -u root app bash -c "rm -fR vendor web .editorconfig .gitattributes composer.lock sold-data/data config.zip"
docker-compose run app bash docker/install.sh
docker-compose restart solr
