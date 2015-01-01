deploy: image

image: index
	docker build -t blog .

dev: image
	docker run -t -i -p 8080:80 \
		-v $$PWD/themes:/var/www/html/themes \
		-v $$PWD/content:/var/www/html/content \
		blog

debug: image
	docker run -t -i -p 8080:80 \
		-v $$PWD/themes:/var/www/html/themes \
		-v $$PWD/content:/var/www/html/content \
		--entrypoint=/bin/bash blog

index:
	cd content && ../make_index
