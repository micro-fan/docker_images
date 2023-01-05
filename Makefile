TAG_NAME ?= staging
GHCR_NAME ?= ghcr.io/micro-fan/python:$(TAG_NAME)
BUILD_HELM ?= 1
PY_VERSION ?= python3.9


.img.built: Dockerfile.base_python app/Dockerfile base_python/install_basic_packages.sh
	docker build -f Dockerfile.base_python . -t base_python --build-arg PY_VERSION=$(PY_VERSION)
	docker build -f app/Dockerfile . -t base_app
	touch .img.built

test: .img.built
	docker run --env-file=env.list --rm=true -it base_app /bin/bash

build_hub_image:
	docker build -f Dockerfile.base_python . \
		-t fan0/base_python:$(TAG_NAME) --build-arg PY_VERSION=$(PY_VERSION)

push_hub_image: build_hub_image
	docker push fan0/base_python:$(TAG_NAME)


build_ghcr_image:
	docker build -f Dockerfile.base_python \
		--build-arg BUILD_HELM=$(BUILD_HELM) . \
		-t $(GHCR_NAME) --build-arg PY_VERSION=$(PY_VERSION)


push_ghcr_image: build_ghcr_image
	@echo Push: $(GHCR_NAME)
	docker push $(GHCR_NAME)
