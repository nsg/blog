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

git-tag:
	git tag `git describe --tags | awk -F. '{print $$1"."$$NF+1}'`

docker-tag: git-tag
	docker tag nsgb/blog nsgb/blog:`git describe --tags`

git-push:
	git push
	git push --tags

docker-push: image docker-tag
	docker push nsgb/blog:`git describe --tags`

deploy: docker-push git-push
	shdeploy \
		-H nsg.cc \
		-d www \
		-i nsgb/blog:`git describe --tags` \
		-o nsg.cc
