build:
	make -C docker

shell: build
	docker run -it \
	    -v $$PWD:/yaml-editor \
	    yamlio/yaml-editor bash

push:
	docker push yamlio/yaml-editor

clean:
	make -C docker clean
