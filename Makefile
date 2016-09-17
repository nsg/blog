TAG := $(shell date +%Y-%m-%d_%H%M%S)
IMAGE = nsgb/blog

status:
	git status --porcelain | wc -l | grep 0

image:
	docker build -t ${IMAGE} .

reimage:
	docker build --no-cache -t ${IMAGE} .

run: image
	docker run -ti -p 8080:8080 -v $$PWD/site:/site ${IMAGE} \
		hugo server --buildDrafts --bind 0.0.0.0 -p 8080 --baseURL="http://localhost"

bash: image
	docker run -ti -p 8080:8080 -v $$PWD/site:/site ${IMAGE} bash

docker-tag: status
	docker tag ${IMAGE} ${IMAGE}:${TAG}
	docker tag -f ${IMAGE} ${IMAGE}:latest
	git tag ${TAG} -m "Pushed to Docker Hub"

docker-push: image docker-tag
	docker push ${IMAGE}:${TAG}
	docker push ${IMAGE}:latest
	git push
	git push --tags

deploy: docker-push
	ssh root@nsg.cc service blog restart
