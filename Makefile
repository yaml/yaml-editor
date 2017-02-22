DOCKER_REPO ?= yamlio

build:
	make -C docker

shell: build
	docker run -it \
	    -v $$PWD:/yaml-editor \
	    yamlio/yaml-editor bash

push:
	docker push $(DOCKER_REPO)/yaml-editor

clean:
	make -C docker clean
