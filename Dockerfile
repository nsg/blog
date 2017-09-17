FROM ubuntu:17.10
MAINTAINER Stefan Berggren

RUN apt-get -y update \
	&& apt-get -y install hugo \
	&& rm -rf /var/lib/apt/lists/*

ENV USER blog
RUN adduser --gecos FALSE --disabled-password --disabled-login $USER
USER $USER

ADD site /site
WORKDIR /site/blog

# Production parameters
CMD hugo server \
	--bind 0.0.0.0 \
	-p 8080 \
	--appendPort=false \
	--baseURL="https://nsg.cc" \
	--disableLiveReload=true \
	--log=true
