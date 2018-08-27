# Etherpad-Lite Dockerfile
#
# https://github.com/ether/etherpad-docker
#
# Version 1.0

# Use Docker's nodejs, which is based on alpine
FROM node:10.9.0-alpine
MAINTAINER Nils Jakobi, jakobi.nils@gmail.com

# Get Etherpad-lite's other dependencies
RUN apk update && apk add \
  gcc \
  g++ \
  libc-dev \
  make \
  curl \
  gzip \
  git \
  libssl1.0 \
  zlib \
  python3 \
  supervisor

# Grab the latest Git version
RUN cd /opt && git clone https://github.com/ether/etherpad-lite.git etherpad

# Install node dependencies
RUN /opt/etherpad/bin/installDeps.sh

# Add conf files
ADD settings.json /opt/etherpad/settings.json
ADD supervisor.conf /etc/supervisor/supervisor.conf

EXPOSE 9001
CMD ["supervisord", "-c", "/etc/supervisor/supervisor.conf", "-n"]
