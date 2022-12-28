# https://github.com/getzola/zola/pkgs/container/zola
FROM ghcr.io/getzola/zola:v0.16.1 AS build

ADD site /site
WORKDIR /site

RUN ["/bin/zola", "build", "--output-dir", "/public"]

FROM docker.io/joseluisq/static-web-server:2
COPY --from=build /public /public
# support legacy RSS URL
COPY --from=build /public/rss.xml /public/index.xml
COPY --from=build /public/rss.xml /public/post/index.xml
COPY --from=build /public/rss.xml /public/tags/index.xml
ENV SERVER_PORT 8080
ENV SERVER_ROOT /public
ENV SERVER_ERROR_PAGE_404 /public/404/index.html
