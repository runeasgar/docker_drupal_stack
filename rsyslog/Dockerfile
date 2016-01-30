FROM ubuntu:14.04
MAINTAINER Joshua Taylor

# Install general ubuntu packages
RUN /bin/bash -c 'apt-get update && apt-get install vim -y'

# Configure VIM
RUN /bin/bash -c 'echo "set nocompatible" > ~/.vimrc && echo "set backspace=2" >> ~/.vimrc'

# Run rsyslog in the foreground
RUN /bin/bash -c 'service rsyslog stop'
CMD rsyslogd -n
