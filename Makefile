IMAGE = nsgb/blog
ZOLA_IMAGE = ghcr.io/getzola/zola:v0.16.1
HOSTNAME := $(shell hostname)

run:
	podman run \
		-v$(shell pwd)/site:/site \
		--workdir /site \
		-p 1111:1111 \
		-p 1024:1024 \
		${ZOLA_IMAGE} \
			serve \
				-p 1111 \
				-i 0.0.0.0 \
				--base-url "${HOSTNAME}.lan.nsgsrv.net"

build:
	podman run \
		-v$(shell pwd)/site:/site \
		--workdir /site \
		${ZOLA_IMAGE} build -o /site/build-out

runprod: build-image
	podman run -p 8080:8080 ${IMAGE}

build-image:
	podman build -t ${IMAGE} .

deploy: build-image
	podman tag ${IMAGE} ${IMAGE}:prod
	podman push ${IMAGE}:prod
