TAG_NAME ?= staging

test:
	docker build -f Dockerfile.base_python . -t base_python
	docker build -f app/Dockerfile . -t base_app
	docker run --env-file=env.list --rm=true -it base_app /bin/bash

build_base_python:
	docker build -f Dockerfile.base_python . -t docker.gettipsi.com:13011/base_python:$(TAG_NAME)

build_hub_image:
	docker build -f Dockerfile.base_python . -t tipsi/base_python:$(TAG_NAME)

push_hub_image: build_hub_image
	docker push tipsi/base_python:$(TAG_NAME)
