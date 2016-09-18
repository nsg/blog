FROM ubuntu:16.04
MAINTAINER Stefan Berggren

RUN apt-get -y update
RUN apt-get -y install wget

# Download and install hugo from debian sid, latest release not synced to
ENV HUGO_VERSION hugo_0.16-2_amd64.deb
RUN wget http://ftp.se.debian.org/debian/pool/main/h/hugo/$HUGO_VERSION \
	&& echo "04d138baa155abe59dc8a1ce33ac1128b51205d2  $HUGO_VERSION" | sha1sum -c - \
	&& dpkg -i $HUGO_VERSION && rm $HUGO_VERSION

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
	--baseURL="http://nsg.cc" \
	--disableLiveReload=true \
	--log=true
