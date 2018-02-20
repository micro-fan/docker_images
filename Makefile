TAG_NAME ?= wip_branch

test:
	docker build -f base_python/Dockerfile . -t base_python
	docker build -f app/Dockerfile . -t base_app
	docker run --env-file=env.list --rm=true -it base_app /bin/bash

build_base_python:
	docker build -f base_python/Dockerfile . -t docker.gettipsi.com:13011/base_python:$(TAG_NAME)
