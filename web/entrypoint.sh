#!/bin/bash
# I have to do things in this script that need to be added to mounted volumes, because volumes aren't mounted to images - only containers

if [ ! -d /var/www/html ]
  then

# Set working directory
cd /var/www/

# Move Drupal to html
# This is a bit tricky because of a problem in AUFS: https://github.com/docker/docker/issues/4570
shopt -s dotglob
rm -r ./html
mv /root/drupal ./html
shopt -u dotglob

# Settings.php and default files stuff - this really shouldn't be needed! How can I fix that?
#cp /var/www/html/sites/default/default.settings.php /var/www/html/sites/default/settings.php
#chmod g+w /var/www/html/sites/default/settings.php
#chmod g+w /var/www/html/sites/default

# Set proper Apache permissions
chown -R root:www-data .
chmod -R g+s .

# Set proper Drupal permissions
cd /var/www/html
find . -type d -exec chmod u=rwx,g=rx,o= '{}' \;
find . -type f -exec chmod u=rw,g=r,o= '{}' \;
chown www-data:www-data ./sites/default
chown www-data:www-data ./sites/default/default.settings.php

# Put the default virtual host in place
# It was wiped out when we mounted /etc/apache2/sites-enabled as a volume
mv /root/000-default.conf /etc/apache2/sites-enabled/

fi

# Run Apache
/usr/sbin/apache2ctl -D FOREGROUND
