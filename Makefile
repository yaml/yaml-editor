default: help

help:
	@echo 'help   - Show help'

clean:
	rm -fr docker/yaml-pegex-pm
	git clean -dxf

docker-build: docker/yaml-pegex-pm
	docker build -t yamlio/yaml-editor docker

docker-shell: docker-build
	docker run -it -v $$PWD:/yaml-editor yamlio/yaml-editor bash

docker-push:
	docker push yamlio/yaml-editor

docker/yaml-pegex-pm:
	cp -r ../${@:docker/%=%} $@
