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
	git tag `git tag | tail -1 | awk -F. '{print $$1"."$$NF+1}'`

docker-tag: git-tag
	docker tag nsgb/blog nsgb/blog:`git tag | tail -1`

push: image docker-tag
	docker push nsgb/blog:`git tag | tail -1`

deploy: push
	shdeploy \
		-H nsg.cc \
		-d www \
		-i nsgb/blog:`git tag | tail -1` \
		-o nsg.cc
