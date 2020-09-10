TAG_NAME ?= staging


.img.built: Dockerfile.base_python app/Dockerfile base_python/install_basic_packages.sh
	docker build -f Dockerfile.base_python . -t base_python
	docker build -f app/Dockerfile . -t base_app
	touch .img.built

test: .img.built
	docker run --env-file=env.list --rm=true -it base_app /bin/bash

build_hub_image:
	docker build -f Dockerfile.base_python . -t fan0/base_python:$(TAG_NAME)

push_hub_image: build_hub_image
	docker push fan0/base_python:$(TAG_NAME)
