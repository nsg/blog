FROM docker.io/klakegg/hugo:0.91.2

WORKDIR /src/blog

# Production parameters
CMD ["server", "--bind 0.0.0.0", "-p 8080", "--appendPort=false", "--baseURL=https://nsg.cc", "--disableLiveReload=true", "--log=true", "--minify"]
