FROM ubuntu
MAINTAINER Joshua Taylor

# STUFF THAT RARELY CHANGES
# We'll be listening on port 80
EXPOSE 80
# Add repositories
RUN /bin/bash -c '\
echo "deb http://us.archive.ubuntu.com/ubuntu/ trusty multiverse" >> /etc/apt/sources.list && \
echo "deb-src http://us.archive.ubuntu.com/ubuntu/ trusty multiverse" >> /etc/apt/sources.list && \
echo "deb http://us.archive.ubuntu.com/ubuntu/ trusty-updates multiverse" >> /etc/apt/sources.list && \
echo "deb-src http://us.archive.ubuntu.com/ubuntu/ trusty-updates multiverse" >> /etc/apt/sources.list && \
echo "deb http://download.webmin.com/download/repository sarge contrib" >> /etc/apt/sources.list'
# Update apt-get after adding repositories
RUN /bin/bash -c 'apt-get update'
# Install common packages
RUN /bin/bash -c 'apt-get install wget vim curl bash-completion git -y'
# Tool for adding repos
RUN /bin/bash -c 'apt-get install software-properties-common python-software-properties -y'
# Add repositories
RUN /bin/bash -c 'add-apt-repository ppa:ondrej/php5'
# Update apt-get after adding repositories
RUN /bin/bash -c 'apt-get update'
# Get a key for webmin
RUN /bin/bash -c 'wget -q http://www.webmin.com/jcameron-key.asc -O- | sudo apt-key add -'
# Configure VIM
RUN /bin/bash -c 'echo "set nocompatible" > ~/.vimrc && echo "set backspace=2" >> ~/.vimrc'
# END STUFF THAT RARELY CHANGES

# Install container-specific ubuntu packages
RUN /bin/bash -c 'apt-get --force-yes install apache2 php5-cli php5-mysqlnd mysql-client libapache2-mod-fastcgi -y'

# Isolating webmin for now since it's taking so much effort to get working
RUN /bin/bash -c 'rm /etc/apt/apt.conf.d/docker-gzip-indexes'
RUN /bin/bash -c 'apt-get update'
RUN /bin/bash -c 'apt-get install apt-show-versions webmin -y'

# CONFIGURATION
# Install drush & prepare files for default Drupal site (installed by ENTRYPOINT)
# This is all back to back to enable docker image layer caching during builds, since downloading Drupal is a relatively lengthy operation
RUN /bin/bash -c 'wget http://files.drush.org/drush.phar && chmod +x drush.phar && mv drush.phar /usr/local/bin/drush'
# && drush init -y' this is not working for some reason
RUN /bin/bash -c 'drush dl --destination=/root drupal && shopt -s dotglob && mv /root/drupal-8.*.* /root/drupal && shopt -u dotglob'
RUN /bin/bash -c 'cp /etc/apache2/sites-enabled/000-default.conf /root/'
# Install Drupal console
RUN /bin/bash -c 'curl https://drupalconsole.com/installer -L -o drupal.phar && mv drupal.phar /usr/local/bin/drupal && chmod +x /usr/local/bin/drupal && drupal init --override'
# Enable autocompletion
RUN /bin/bash -c 'echo source \"$HOME/.console/console.rc\" 2>/dev/null'

# Add default files
ADD ./php5-fpm.conf /etc/apache2/conf-available/php5-fpm.conf
ADD ./.gitconfig /root/.gitconfig
ADD ./entrypoint.sh /entrypoint.sh
# Fix perms on entry script
RUN /bin/bash -c 'chmod u+x /entrypoint.sh'
# Work with apache mods after php5-fpm.conf created
RUN /bin/bash -c 'a2dismod mpm_prefork mpm_event && a2enmod rewrite actions fastcgi alias mpm_worker && a2enconf php5-fpm'
# apache.conf changes
RUN /bin/bash -c 'sed -i "166 s/None/All/" /etc/apache2/apache2.conf && sed -i "s/KeepAliveTimeout 5/KeepAliveTimeout 2/" /etc/apache2/apache2.conf'

# Set the working directory when you shell into the server
WORKDIR /var/www

# Run entry script
ENTRYPOINT exec /entrypoint.sh
