TAG := $(shell date +%Y-%m-%d_%H%M%S)
IMAGE = nsgb/blog
DOCKER ?= sudo docker
HOSTNAME := $(shell hostname)
KUBECTL := kubectl --kubeconfig ${HOME}/.kube/k8s.yaml

run: build
	${DOCKER} run -ti -p 8080:8080 -v $$PWD/site:/src ${IMAGE} \
		server --disableFastRender --buildDrafts --bind 0.0.0.0 -p 8080 --baseURL="http://${HOSTNAME}.lan.nsgsrv.net"

build: site/blog/themes/blackburn/theme.toml
	${DOCKER} build -t ${IMAGE} .

site/blog/themes/blackburn/theme.toml:
	git submodule update --init --recursive

push: build
	${DOCKER} tag ${IMAGE} ${IMAGE}:${TAG}
	${DOCKER} push ${IMAGE}:${TAG}
	${DOCKER} push ${IMAGE}:latest

deploy: push
	${KUBECTL} set image deployment/nsgcc blog=nsgb/blog:${TAG}
