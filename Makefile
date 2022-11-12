TAG := $(shell date +%Y-%m-%d_%H%M%S)
IMAGE = nsgb/blog
DOCKER ?= podman
HOSTNAME := $(shell hostname)

run: build
	${DOCKER} run -ti -p 8080:8080 -v $$PWD/site:/src  ${IMAGE} \
		server --disableFastRender --buildDrafts --bind 0.0.0.0 -p 8080 --baseURL="http://${HOSTNAME}.lan.nsgsrv.net"

run-prod: build
	${DOCKER} run -ti -p 8080:8080 ${IMAGE}

build: site/blog/themes/blackburn/theme.toml
	echo > site/blog/themes/blackburn/layouts/partials/share.html
	${DOCKER} build -t ${IMAGE} .
	git -C site/blog/themes/blackburn checkout -- layouts/partials/share.html

site/blog/themes/blackburn/theme.toml:
	git submodule update --init --recursive

push: build
	${DOCKER} tag ${IMAGE} ${IMAGE}:${TAG}
	${DOCKER} push ${IMAGE}:${TAG}
	${DOCKER} push ${IMAGE}:latest

deploy: push
	${DOCKER} tag ${IMAGE} ${IMAGE}:prod
	${DOCKER} push ${IMAGE}:prod
