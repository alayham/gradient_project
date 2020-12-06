#!/bin/bash
rm -fR vendor web .editorconfig .gitattributes composer.lock
mkdir -p config/sync
composer install
drush -y si gradient_server \
  --db-url=mysql://drupal_database_user:drupal_database_password@mysql/gradient_server \
  --db-su=root \
  --db-su-pw=root_password \
  --account-name=admin \
  --account-mail=test@example.com \
  --site-mail=test@example.com \
  --account-pass=test \
  --site-name="Gradient Server Demo" \
  --config-dir="../config/sync" 
chmod -R o+w web/sites/default/files
drush cr