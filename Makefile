IMAGE = nsgb/blog
HOSTNAME := $(shell hostname)

run: build
	podman run -v$(shell pwd)/site:/site -p 1111:1111 -p 1024:1024 ${IMAGE} serve -p 1111 -i 0.0.0.0 --base-url "${HOSTNAME}.lan.nsgsrv.net"

runprod: build
	podman run -p 8080:8080 ${IMAGE}

build: build-image
	podman run -v$(shell pwd)/site:/site ${IMAGE} build

build-image:
	podman build -t ${IMAGE} .

deploy: build
	podman tag ${IMAGE} ${IMAGE}:prod
	podman push ${IMAGE}:prod
