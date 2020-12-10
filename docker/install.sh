composer install
mkdir -p config/sync
mkdir -p web/sites/default/files
chmod 777 web/sites/default/files
cp web/sites/default/default.settings.php web/sites/default/settings.php
chmod 666 web/sites/default/settings.php
vendor/bin/drush -y si gradient_server \
  --db-url=mysql://drupal_database_user:drupal_database_password@mysql/gradient_server \
  --db-su=root  \
  --db-su-pw=root_password \
  --account-name=admin \
  --account-mail=test@example.com \
  --site-mail=test@example.com \
  --account-pass=test \
  --site-name='Gradient Server Demo' \
  --config-dir='../config/sync'  \
vendor/bin/drush cr;
vendor/bin/drush -y en gradient_search 
vendor/bin/drush -y cset search_api.server.solr backend_config.connector_config.host solr
vendor/bin/drush -y cset search_api.index.content status true
vendor/bin/drush solr-gsc solr ../config.zip
unzip -o -d solr-data/conf config.zip;
rm -f config.zip;