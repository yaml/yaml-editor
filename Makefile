DOCKER_FILES := \
    nim \
    yaml2yeast \
    yaml-pegex-pm \

DOCKER_FILES := $(DOCKER_FILES:%=docker/files/%)

default: help

help:
	@echo 'help   - Show help'

clean:
	rm -fr docker/files/yaml-pegex-pm/
	git clean -dxf

docker-build: $(DOCKER_FILES)
	docker build -t yamlio/yaml-editor ./docker

docker-shell: docker-build
	docker run -it \
	    -v $$PWD:/yaml-editor \
	    yamlio/yaml-editor bash

docker-push:
	docker push yamlio/yaml-editor

docker/files/yaml-pegex-pm:
	cp -r ../yaml-pegex-pm $@

docker/files/nim:
	wget http://nim-lang.org/download/nim-0.16.0.tar.xz
	tar xJf nim-0.16.0.tar.xz
	mv nim-0.16.0 $@
	rm nim-0.16.0.tar.xz

docker/files/yaml2yeast:
	cp ../yamlreference/dist/build/yaml2yeast/yaml2yeast $@
