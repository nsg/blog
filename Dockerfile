FROM nsgb/baseimage:v2
MAINTAINER Stefan Berggren

RUN apt-get -y install apache2 php5 curl unzip

# Setup Apache
RUN mkdir /logs && chown www-data:www-data /logs
ADD apache.conf /etc/apache2/sites-available/site.conf
RUN a2dissite 000-default.conf
RUN a2ensite site.conf
RUN a2enmod rewrite
RUN rm /var/www/html/index.html

# Setup PicoCMS
RUN curl -L -o /tmp/picocms.zip https://github.com/picocms/Pico/archive/master.zip
RUN echo "ec2d832c3d62b1602a99a6ddd87a3af98f78a53c  /tmp/picocms.zip" | sha1sum -c -
RUN unzip /tmp/picocms.zip && rm /tmp/picocms.zip
RUN cp -r Pico-master/* Pico-master/.htaccess /var/www/html && rm -rf Pico-master
RUN rm -r /var/www/html/content/*
RUN rm -r /var/www/html/themes/*
ADD htaccess /var/www/html/.htaccess

# Setup Pico RSS
RUN curl -L -o /tmp/pico-rss_1.2.tar.gz https://github.com/nsg/Pico-RSS-Plugin/archive/1.2.tar.gz
RUN echo "283452ac7d030db0e0b328e0ca7d84da0e560837  /tmp/pico-rss_1.2.tar.gz | sha1sum -c -"
RUN tar xf /tmp/pico-rss_1.2.tar.gz && rm /tmp/pico-rss_1.2.tar.gz
RUN mv Pico-RSS-Plugin-1.2/pico_rss /var/www/html/plugins/

# Setup Pico Cache
RUN curl -L -o /var/www/html/plugins/pico_cache.php https://raw.githubusercontent.com/glumb/pico_cache/c3e024729c7d98cce9b550ebe0eb5870a91b7eca/pico_cache.php
RUN echo "da6546ff86f6c5335f4b8571418d93642a21daec  /var/www/html/plugins/pico_cache.php" | sha1sum -c -

# Setup Pico Tags
RUN curl -L -o /var/www/html/plugins/pico_tags.php https://raw.githubusercontent.com/nsg/picocms-tags/400-if-tag-not-found/pico-tags.php
#RUN echo "a3b4490e7e7ffda47b46f80ac09f51121c747774  /var/www/html/plugins/pico_tags.php" | sha1sum -c -

# Add content to image
ADD content /var/www/html/content
ADD themes /var/www/html/themes
ADD config.php /var/www/html/config.php

ADD supervisor.conf /etc/supervisor/conf.d/
ADD debug /usr/local/bin/debug
RUN chmod +x /usr/local/bin/debug
