TAG=$(shell date +%Y-%m-%d_%H%M%S)

status:
	git status --porcelain | wc -l | grep 0

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

docker-tag: status
	docker tag nsgb/blog nsgb/blog:${TAG}
	docker tag -f nsgb/blog nsgb/blog:latest
	git tag ${TAG} -m "Pushed to Docker Hub"

docker-push: image docker-tag
	docker push nsgb/blog:${TAG}
	docker push nsgb/blog:latest

deploy: docker-push
	ssh root@app.stefanberggren.se service blog restart
