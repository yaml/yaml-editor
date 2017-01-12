default: help

help:
	@echo 'help   - Show help'

clean:
	rm -fr docker/yaml-pegex-pm
	git clean -dxf

docker-build: docker/yaml-pegex-pm docker/nim docker/nim_events.nim
	docker build -t yamlio/yaml-editor docker

docker-shell: docker-build
	docker run -it -v $$PWD:/yaml-editor yamlio/yaml-editor bash

docker-push:
	docker push yamlio/yaml-editor

docker/yaml-pegex-pm:
	cp -r ../${@:docker/%=%} $@

docker/nim:
	wget http://nim-lang.org/download/nim-0.16.0.tar.xz
	tar xJf nim-0.16.0.tar.xz
	mv nim-0.16.0 $@
	rm nim-0.16.0.tar.xz

docker/nim_events.nim:
	cp src/* docker/
