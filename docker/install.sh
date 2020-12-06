#!/bin/bash
mkdir -p config/sync
mkdir -p web/sites/default/files
chmod 777 web/sites/default/files
cp web/sites/default/default.settings.php web/sites/default/settings.php
chmod 666 web/sites/default/settings.php
docker-compose run app drush -y si gradient_server \
  --db-url=mysql://drupal_database_user:drupal_database_password@mysql/gradient_server \
  --db-su=root \
  --db-su-pw=root_password \
  --account-name=admin \
  --account-mail=test@example.com \
  --site-mail=test@example.com \
  --account-pass=test \
  --site-name="Gradient Server Demo" \
  --config-dir="../config/sync" 
docker-compose run app chmod -R o+w web/sites/default/files
docker-compose run app drush cr