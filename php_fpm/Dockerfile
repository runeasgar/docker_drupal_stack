FROM ubuntu
MAINTAINER Joshua Taylor

# We'll be listening on port 9000
EXPOSE 9000

# Download required ubuntu packages
RUN /bin/bash -c 'apt-get update && apt-get install vim php-pear php5-dev php5-fpm php5-mcrypt php5-gd php5-curl php5-mysqlnd -y'

# Configure VIM
RUN /bin/bash -c 'echo "set nocompatible" > ~/.vimrc && echo "set backspace=2" >> ~/.vimrc'

# Set the FPM server to listen for remote connections
RUN /bin/bash -c 'sed -i "s|listen = /var/run/php5-fpm.sock|listen = 0.0.0.0:9000|" /etc/php5/fpm/pool.d/www.conf'

# Set up FPM pool logging
RUN /bin/bash -c 'mkdir /var/log/php5-fpm && sed -it "s|\;access.log = log/\$pool.access.log|access.log = /var/log/php5-fpm/\$pool.access.log|" /etc/php5/fpm/pool.d/www.conf'

# Configure PHP
RUN /bin/bash -c 'sed -i "s|expose_php = On|expose_php = Off|" /etc/php5/fpm/php.ini && sed -i "s|allow_url_fopen = On|allow_url_fopen = Off|" /etc/php5/fpm/php.ini'
RUN /bin/bash -c 'pecl install uploadprogress && echo "extension=uploadprogress.so" > /etc/php5/fpm/conf.d/uploadprogress.ini'

# Set the working dir so we can run in foreground
WORKDIR /etc/init.d

# Run php-fpm in foreground
CMD php5-fpm -F
