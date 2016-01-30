FROM ubuntu:14.04
MAINTAINER Joshua Taylor

# STUFF THAT RARELY CHANGES
# We'll be listening on port 9000
EXPOSE 9000
# Update apt-get
RUN /bin/bash -c 'apt-get update'
# Tool for adding repos
RUN /bin/bash -c 'apt-get install software-properties-common python-software-properties -y'
# Add repositories
RUN /bin/bash -c 'add-apt-repository ppa:ondrej/php5'
# Update apt-get after adding repositories
RUN /bin/bash -c 'apt-get update'
# Install common packages
RUN /bin/bash -c 'apt-get install vim -y'
# Configure VIM
RUN /bin/bash -c 'echo "set nocompatible" > ~/.vimrc && echo "set backspace=2" >> ~/.vimrc'
# END STUFF THAT RARELY CHANGES

# Install container-specific ubuntu packages
RUN /bin/bash -c 'apt-get install php-pear php5-dev php5-fpm php5-mcrypt php5-gd php5-curl php5-mysqlnd php5-xdebug -y --force-yes'

# CONFIGURATION
# Set up php-fpm port
RUN /bin/bash -c 'sed -i "s|listen = /var/run/php5-fpm.sock|listen = 0.0.0.0:9000|" /etc/php5/fpm/pool.d/www.conf'
# Set up php-fpm logging
RUN /bin/bash -c 'mkdir /var/log/php5-fpm && sed -it "s|\;access.log = log/\$pool.access.log|access.log = /var/log/php5-fpm/\$pool.access.log|" /etc/php5/fpm/pool.d/www.conf'
# PHP security changes
RUN /bin/bash -c 'sed -i "s|expose_php = On|expose_php = Off|" /etc/php5/fpm/php.ini && sed -i "s|allow_url_fopen = On|allow_url_fopen = Off|" /etc/php5/fpm/php.ini'
# uploadprogress for Drupal
RUN /bin/bash -c 'pecl install uploadprogress && echo "extension=uploadprogress.so" > /etc/php5/fpm/conf.d/uploadprogress.ini'
# xdebug for Drupal
RUN /bin/bash -c 'echo "xdebug.max_nesting_level=256" >> /etc/php5/fpm/conf.d/20-xdebug.ini'

# Set the working dir so we can run in foreground
WORKDIR /etc/init.d

# Run php-fpm in foreground
CMD php5-fpm -F
