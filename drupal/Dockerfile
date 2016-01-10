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

# Expose port 80
EXPOSE 80

# Add default files
ADD default.gitconfig /root/.gitconfig

# Set the working directory for sake of organization
WORKDIR /var/www

# Run Apache
CMD /usr/sbin/apache2ctl -D FOREGROUND
