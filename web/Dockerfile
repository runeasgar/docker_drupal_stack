FROM ubuntu
MAINTAINER Joshua Taylor

# Install ubuntu packages
RUN /bin/bash -c 'apt-get update && apt-get install wget vim curl git php5 libapache2-mod-php5 php5-mcrypt php5-gd php5-mysqlnd -y'

# Install drush
RUN /bin/bash -c 'wget http://files.drush.org/drush.phar && chmod +x drush.phar && mv drush.phar /usr/local/bin/drush && drush init'

# Install Drupal console
RUN /bin/bash -c 'curl https://drupalconsole.com/installer -L -o drupal.phar && mv drupal.phar /usr/local/bin/drupal && chmod +x /usr/local/bin/drupal && drupal init --override'

# Enable Apache mods
RUN /bin/bash -c 'a2enmod rewrite'

# Add default files
ADD ./.gitconfig /root/.gitconfig
ADD ./apache2.conf /etc/apache2/apache2.conf

# Enable overrides in /var/www
# This is not working. Ran as a part of dockc up, it does nothing. Ran on the container after it spins up, it results in an empty file. There has to be an easier way. Limit by line?
# RUN /bin/bash -c 'cat /etc/apache2/apache2.conf | tr \'\n\' \'\r\' | sed \'s|\(/var/www/>\r.*\r.*\)None|\1All|\' | tr \'\r\' \'\n\' > /etc/apache2/apache2.conf'

# Expose port 80
EXPOSE 80

# Set the working directory for sake of organization
WORKDIR /var/www

# Run Apache
CMD /usr/sbin/apache2ctl -D FOREGROUND
