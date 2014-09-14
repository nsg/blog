FROM ubuntu:14.04
MAINTAINER Stefan Berggren
VOLUME ["/var/repos/blog.git"]
RUN apt-get -y update
RUN apt-get -y install apache2 php5 git
RUN git clone /var/repos/blog.git /var/www/html/blog
