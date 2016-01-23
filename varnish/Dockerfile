FROM ubuntu
MAINTAINER Joshua Taylor

# Install general ubuntu packages
RUN /bin/bash -c 'apt-get update && apt-get install wget vim curl git -y'

# Configure VIM
RUN /bin/bash -c 'echo "set nocompatible" > ~/.vimrc && echo "set backspace=2" >> ~/.vimrc'

# Install Varnish
RUN /bin/bash -c 'apt-get install apt-transport-https && curl https://repo.varnish-cache.org/GPG-key.txt | apt-key add - && \
echo "deb https://repo.varnish-cache.org/ubuntu/ trusty varnish-4.1" >> /etc/apt/sources.list.d/varnish-cache.list && \
apt-get update && apt-get install varnish -y'

# Expose port 80
EXPOSE 80

# Set the working directory for sake of organization
WORKDIR /etc/varnish

# Add default VCL
ADD default.vcl /etc/varnish/default.vcl

# Run Varnish
CMD varnishd -F -f /etc/varnish/default.vcl
