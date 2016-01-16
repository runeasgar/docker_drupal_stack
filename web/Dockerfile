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

# Download Drupal to a non-volume directory so we can simply move it later
RUN /bin/bash -c 'drush dl --destination=/root drupal && shopt -s dotglob && mv /root/drupal-8.*.* /root/drupal && shopt -u dotglob'

# Copy 000-default.conf so we can use it later
RUN /bin/bash -c 'cp /etc/apache2/sites-enabled/000-default.conf /root/'

# Add default files
ADD ./apache2.conf /etc/apache2/apache2.conf
ADD ./.gitconfig /root/.gitconfig
ADD ./entrypoint.sh /entrypoint.sh

# Fix perms on entry script
RUN /bin/bash -c 'chmod u+x /entrypoint.sh'

# Run entry script
ENTRYPOINT exec /entrypoint.sh
