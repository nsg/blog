FROM ubuntu:14.04
MAINTAINER Stefan Berggren

RUN apt-get -y update
RUN apt-get -y install supervisor

ENTRYPOINT /usr/bin/supervisord -c /etc/supervisor/supervisord.conf --nodaemon

RUN apt-get -y install apache2 php5 curl unzip

# Setup Apache
RUN mkdir /logs && chown www-data:www-data /logs
ADD apache.conf /etc/apache2/sites-available/site.conf
RUN a2dissite 000-default.conf
RUN a2ensite site.conf
RUN a2enmod rewrite
RUN rm /var/www/html/index.html

# Download composer
RUN curl -L -o /usr/local/bin/composer https://getcomposer.org/download/1.0.0-alpha10/composer.phar \
	&& echo "5913d2b2a0cb07e9a2d620bd1f66340ec676e28a  /usr/local/bin/composer" | sha1sum -c - \
	&& chmod +x /usr/local/bin/composer

# Drop privs to pico user
RUN adduser --gecos FALSE --disabled-password --disabled-login \
	--uid $(( 9000 + $(tr -cd 0-9 </dev/urandom | head -c 3) )) \
	pico
RUN chown -R pico /var/www/html/
USER pico
WORKDIR /tmp

# Setup PicoCMS
RUN curl -L -o /tmp/picocms.tar.gz https://github.com/picocms/Pico/archive/v0.9.tar.gz \
	&& echo "a3aa45de6b220157bbdc2b995cab8b390b69b107  /tmp/picocms.tar.gz" | sha1sum -c - \
	&& tar xf /tmp/picocms.tar.gz && rm /tmp/picocms.tar.gz \
	&& cp -r Pico-*/* Pico-*/.htaccess /var/www/html && rm -rf Pico-* \
	&& rm -r /var/www/html/content-sample /var/www/html/themes/*
ADD htaccess /var/www/html/.htaccess

# Setup Pico RSS
RUN curl -L -o /tmp/pico-rss_1.2.tar.gz https://github.com/nsg/Pico-RSS-Plugin/archive/1.2.tar.gz \
	&& echo "283452ac7d030db0e0b328e0ca7d84da0e560837  /tmp/pico-rss_1.2.tar.gz | sha1sum -c -" \
	&& tar xf /tmp/pico-rss_1.2.tar.gz && rm /tmp/pico-rss_1.2.tar.gz \
	&& mv Pico-RSS-Plugin-1.2/pico_rss /var/www/html/plugins/

# Setup Pico Cache
RUN curl -L -o /var/www/html/plugins/pico_cache.php https://raw.githubusercontent.com/glumb/pico_cache/c3e024729c7d98cce9b550ebe0eb5870a91b7eca/pico_cache.php \
	&& echo "da6546ff86f6c5335f4b8571418d93642a21daec  /var/www/html/plugins/pico_cache.php" | sha1sum -c -

# Setup Pico Tags
RUN curl -L -o /var/www/html/plugins/pico_tags.php https://raw.githubusercontent.com/nsg/picocms-tags/dc50f02c40c0bb5dbd693889a5ca046bcf6b3aac/pico-tags.php \
	&& echo "3a3c724fee216a40011ebbcc504a9c3257c8741b  /var/www/html/plugins/pico_tags.php" | sha1sum -c -

# Exec composer
RUN cd /var/www/html/ && composer install

# Add content to image
ADD content /var/www/html/content
ADD themes /var/www/html/themes
ADD config.php /var/www/html/config.php

USER root

ADD supervisor.conf /etc/supervisor/conf.d/
ADD debug /usr/local/bin/debug
RUN chmod +x /usr/local/bin/debug
