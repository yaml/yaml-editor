DOCKER_USER ?= yamlio

build:
	make -C docker

shell: build
	docker run -it \
	    -v $$PWD:/yaml-editor \
	    yamlio/yaml-editor bash

push:
	docker push $(DOCKER_USER)/yaml-editor

clean:
	make -C docker clean
