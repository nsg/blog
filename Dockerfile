FROM ubuntu:18.04
LABEL maintainer="Stefan Berggren"

ARG HUGO_VERSION=0.49.2
ARG HUGO=https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.deb

RUN apt-get -y update \
	&& apt-get -y install wget \
	&& rm -rf /var/lib/apt/lists/* \
	&& wget ${HUGO} \
	&& dpkg -i *.deb \
	&& rm *.deb

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
