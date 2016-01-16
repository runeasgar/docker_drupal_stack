#!/bin/bash
# I have to do things in this script that need to be added to mounted volumes, because volumes aren't mounted to images - only containers

if [ ! -d /var/www/html ]
  then

echo wtf

# Move Drupal to html
# This is a bit tricky because of a problem in AUFS: https://github.com/docker/docker/issues/4570
shopt -s dotglob
rm -r /var/www/html
mv /root/drupal /var/www/html
shopt -u dotglob

# Settings.php and default files stuff - this really shouldn't be needed! How can I fix that?
cp /var/www/html/sites/default/default.settings.php /var/www/html/sites/default/settings.php
chmod g+w /var/www/html/sites/default/settings.php
chmod g+w /var/www/html/sites/default

# Set proper Apache permissions
chown -R root:www-data /var/www
chmod -R g+s /var/www

# Put the default virtual host in place
# It was wiped out when we mounted /etc/apache2/sites-enabled as a volume
mv /root/000-default.conf /etc/apache2/sites-enabled/

fi

# Run Apache
/usr/sbin/apache2ctl -D FOREGROUND
