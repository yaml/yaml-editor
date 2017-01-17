default: help

help:
	@echo 'help   - Show help'

clean:
	rm -fr docker/files

docker-build: docker/files/yaml-pegex-pm docker/files/nim
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
