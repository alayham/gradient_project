docker-compose run app bash -c "
  drush -y en gradient_search ; 
  drush -y cset search_api.server.solr backend_config.connector_config.host solr ;
  drush -y cset search_api.index.content status true ;
  drush solr-gsc solr ../config.zip ;
"
docker-compose run solr bash -c "
  echo 'name=gradient_core' > /var/solr/data/gradient_core/core.properties ;
  echo 'config=solrconfig.xml' >> /var/solr/data/gradient_core/core.properties ;
  echo 'schema=schema.xml' >> /var/solr/data/gradient_core/core.properties ;
  echo 'dataDir=data' >> /var/solr/data/gradient_core/core.properties ;
  mkdir -p /var/solr/data/gradient_core/conf
  chmod 777 /var/solr/data/gradient_core/conf;
"
unzip -o -d solr-data/conf config.zip;
rm -fR config.zip
docker-compose restart solr
echo "                           Search was enabled."
echo "Visit 'Administration -> Configuration -> Search and metadata -> Search API -> Solr' "
echo "      and verify that the server could be reached and the core could be accessed."
