FROM ubuntu
MAINTAINER Joshua Taylor

# We'll be listening on port 9000
EXPOSE 9000

# Download required ubuntu packages
RUN /bin/bash -c 'apt-get update && apt-get install php5-fpm php5-mcrypt php5-gd php5-mysqlnd -y'

# Set the FPM server to listen for remote connections
RUN /bin/bash -c 'sed -i "s|listen = /var/run/php5-fpm.sock|listen = 0.0.0.0:9000|" /etc/php5/fpm/pool.d/www.conf'

# Fix vimrc
ADD ./.vimrc /root/.vimrc
RUN /bin/bash -c 'source /root/.vimrc'

# Set up FPM pool logging
RUN /bin/bash -c 'mkdir /var/log/php5-fpm && sed -it "s|\;access.log = log/\$pool.access.log|access.log = /var/log/php5-fpm/\$pool.access.log|" /etc/php5/fpm/pool.d/www.conf'

# Set the working dir so we can run in foreground
WORKDIR /etc/init.d

# Run php-fpm in foreground
CMD php5-fpm -F
