# https://github.com/getzola/zola/pkgs/container/zola
FROM ghcr.io/getzola/zola:v0.16.1 AS build

ADD site /site
WORKDIR /site

RUN ["/bin/zola", "build", "--output-dir", "/public"]

# https://hub.docker.com/_/nginx
FROM docker.io/library/nginx:1.22
COPY --from=build /public /usr/share/nginx/html
RUN rm /etc/nginx/nginx.conf /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/nginx.conf

# support legacy RSS URL
#COPY --from=build /public/rss.xml /public/index.xml
#COPY --from=build /public/rss.xml /public/post/index.xml
#COPY --from=build /public/rss.xml /public/tags/index.xml
