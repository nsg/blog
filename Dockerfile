# https://github.com/getzola/zola/pkgs/container/zola
FROM ghcr.io/getzola/zola:v0.22.1 AS build

ADD site /site
WORKDIR /site

RUN ["/bin/zola", "build", "--output-dir", "/public"]

# Tera leaves a newline and its indentation behind for every control tag.
FROM docker.io/library/node:22-slim AS beautify
RUN npm install -g js-beautify@2.0.3
COPY --from=build /public /public
RUN find /public -name '*.html' -exec \
      js-beautify --type html --indent-size 2 --max-preserve-newlines 1 -r {} +

# https://hub.docker.com/_/nginx
FROM docker.io/library/nginx:1.22
COPY --from=beautify /public /usr/share/nginx/html
RUN rm /etc/nginx/nginx.conf /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/nginx.conf

# support legacy RSS URL
#COPY --from=build /public/rss.xml /public/index.xml
#COPY --from=build /public/rss.xml /public/post/index.xml
#COPY --from=build /public/rss.xml /public/tags/index.xml
