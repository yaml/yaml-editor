DOCKER_USER ?= yamlio

build:
	make -C docker

emitter-table:
	docker run -i --rm yamlio/alpine-runtime-all cat /yaml/info/views.table >./share/emitters.table
	docker run -i --rm yamlio/alpine-runtime-all cat /yaml/info/views.csv >./share/emitters.csv

shell: build
	docker run -it \
	    -v $$PWD:/yaml-editor \
	    yamlio/yaml-editor bash

push:
	docker push $(DOCKER_USER)/yaml-editor

clean:
	make -C docker clean
