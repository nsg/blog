FROM ubuntu:14.04
MAINTAINER Stefan Berggren
RUN apt-get -y update
RUN apt-get -y install apache2 php5
