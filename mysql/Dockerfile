FROM mysql
MAINTAINER Joshua Taylor

# Install general ubuntu packages
RUN /bin/bash -c 'apt-get update && apt-get install vim -y'

# Configure VIM
RUN /bin/bash -c 'echo "set nocompatible" > ~/.vimrc && echo "set backspace=2" >> ~/.vimrc'

# Configure MySQL
# Query Cache
RUN /bin/bash -c 'sed -i "/\[mysqld\]/ a query_cache_size=32M" /etc/mysql/my.cnf && sed -i "/\[mysqld\]/ a query_cache_type=1" /etc/mysql/my.cnf'

# Run mysql using the image's existing command
ENTRYPOINT exec /entrypoint.sh mysqld
