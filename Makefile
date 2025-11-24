IMAGE = nsgb/blog
ZOLA_IMAGE = ghcr.io/getzola/zola:v0.19.2
HOSTNAME := $(shell hostname)

debug:
	podman run \
		-v$(shell pwd)/site:/site:z \
		--workdir /site \
		-p 1111:1111 \
		-p 1024:1024 \
		-ti \
		docker.io/library/debian
run:
	podman run \
		-v$(shell pwd)/site:/site:z \
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
		-v$(shell pwd)/site:/site:z \
		--workdir /site \
		${ZOLA_IMAGE} build -o /site/build-out

runprod: build-image
	podman run -p 8080:8080 ${IMAGE}

build-image:
	podman build -t ${IMAGE} .

deploy: build-image
	podman tag ${IMAGE} ${IMAGE}:prod
	podman push ${IMAGE}:prod

new:
	@read -p "Enter blog post title: " title; \
	slug=$$(echo "$$title" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9 ]//g' | sed 's/ /-/g' | sed 's/--*/-/g' | sed 's/^-\|-$$//g'); \
	year=$$(date +%Y); \
	dir="site/content/post/$$year"; \
	file="$$dir/$$slug.md"; \
	mkdir -p "$$dir"; \
	if [ ! -f "$$dir/_index.md" ]; then \
		echo "+++" > "$$dir/_index.md"; \
		echo "title = \"$$year\"" >> "$$dir/_index.md"; \
		echo "sort_by = \"date\"" >> "$$dir/_index.md"; \
		echo "+++" >> "$$dir/_index.md"; \
		echo "Created $$dir/_index.md"; \
	fi; \
	echo "+++" > "$$file"; \
	echo "date = \"$$(date +%Y-%m-%dT%H:%M:%S%z | sed 's/\(..\)$$/:\1/')\"" >> "$$file"; \
	echo "title = \"$$title\"" >> "$$file"; \
	echo "[taxonomies]" >> "$$file"; \
	echo "tags = []" >> "$$file"; \
	echo "+++" >> "$$file"; \
	echo "" >> "$$file"; \
	echo "Created new blog post: $$file"

.PHONY: new
