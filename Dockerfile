# https://github.com/getzola/zola/pkgs/container/zola
FROM ghcr.io/getzola/zola:v0.16.1

ADD site /site
WORKDIR /site

CMD ["serve", "--port", "8080", "-i", "0.0.0.0", "--base-url", "nsg.cc"]
