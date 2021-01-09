FROM klakegg/hugo:0.49.2

ENV USER blog
RUN adduser -g FALSE -D -H $USER
USER $USER

ADD site /src
WORKDIR /site/blog

# Production parameters
CMD server \
	--bind 0.0.0.0 \
	-p 8080 \
	--appendPort=false \
	--baseURL="https://nsg.cc" \
	--disableLiveReload=true \
	--log=true
