FROM ubuntu
MAINTAINER Joshua Taylor

# Expose port 80
EXPOSE 80

# Set the working directory for sake of organization
WORKDIR /var/www

# Install ubuntu packages
RUN /bin/bash -c 'apt-get update && apt-get install wget vim curl git php5 libapache2-mod-php5 php5-mcrypt php5-gd php5-mysqlnd -y'

# Install drush
RUN /bin/bash -c 'wget http://files.drush.org/drush.phar && chmod +x drush.phar && mv drush.phar /usr/local/bin/drush && drush init'

# Install Drupal console
RUN /bin/bash -c 'curl https://drupalconsole.com/installer -L -o drupal.phar && mv drupal.phar /usr/local/bin/drupal && chmod +x /usr/local/bin/drupal && drupal init --override'

# Enable Apache mods
RUN /bin/bash -c 'a2enmod rewrite'

# Install Drupal - on its own to be a cached layer
RUN /bin/bash -c 'drush dl drupal'

# Move Drupal install to html
# This is a bit tricky because of a problem in AUFS: https://github.com/docker/docker/issues/4570
RUN /bin/bash -c 'shopt -s dotglob && rm -r html && mv drupal-8.*.* html && shopt -u dotglob'

# Settings.php file needs to be created, apparently because I am not running Apache/PHP properly
RUN /bin/bash -c 'cp html/sites/default/default.settings.php html/sites/default/settings.php && chmod g+w html/sites/default/settings.php'

# Set proper Apache permissions
RUN /bin/bash -c 'chown -R root:www-data /var/www && chmod -R g+s /var/www && chmod g+w /var/www/html/sites/default'

# Add default files
ADD ./apache2.conf /etc/apache2/apache2.conf
ADD ./.gitconfig /root/.gitconfig

# Run Apache
CMD /usr/sbin/apache2ctl -D FOREGROUND
