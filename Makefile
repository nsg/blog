TAG := $(shell date +%Y-%m-%d_%H%M%S)
IMAGE = nsgb/blog
DOCKER ?= sudo docker
HOSTNAME := $(shell hostname)

status:
	git status --porcelain | wc -l | grep 0

image: site/blog/themes/blackburn/theme.toml
	${DOCKER} build -t ${IMAGE} .

reimage:
	${DOCKER} build --no-cache -t ${IMAGE} .

run: image
	${DOCKER} run -ti -p 8080:8080 -v $$PWD/site:/site ${IMAGE} \
		hugo server --buildDrafts --bind 0.0.0.0 -p 8080 --baseURL="http://${HOSTNAME}.lan.nsgsrv.net"

bash: image
	${DOCKER} run -ti -p 8080:8080 -v $$PWD/site:/site ${IMAGE} bash

docker-tag: status
	${DOCKER} tag ${IMAGE} ${IMAGE}:${TAG}
	${DOCKER} tag ${IMAGE} ${IMAGE}:latest
	git tag ${TAG} -m "Pushed to Docker Hub"

site/blog/themes/blackburn/theme.toml:
	git submodule update --init --recursive

docker-push: image docker-tag
	${DOCKER} push ${IMAGE}:${TAG}
	${DOCKER} push ${IMAGE}:latest
	git push
	git push --tags
