image: index
	docker build -t nsgb/blog .

reimage:
	docker build --no-cache -t nsgb/blog .

dev: image
	docker run -t -i -p 8080:80 \
		-v $$PWD/themes:/var/www/html/themes \
		-v $$PWD/content:/var/www/html/content \
		nsgb/blog

debug: image
	docker run -t -i -p 8080:80 \
		-v $$PWD/themes:/var/www/html/themes \
		-v $$PWD/content:/var/www/html/content \
		--entrypoint=/usr/local/bin/debug nsgb/blog

index:
	cd content && ../make_index

tag:
	docker tag nsgb/blog nsgb/blog:`git tag | tail -1`

push: image tag
	docker push nsgb/blog:`git tag | tail -1`
