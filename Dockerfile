FROM ubuntu:14.04
MAINTAINER Stefan Berggren
RUN apt-get -y update
RUN apt-get -y install apache2 php5 git
ADD . /repo
ADD apache.conf /etc/apache2/sites-available/site.conf
RUN a2dissite 000-default.conf
RUN a2ensite site.conf
RUN mkdir /logs
RUN service apache2 reload
