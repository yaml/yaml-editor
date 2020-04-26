#------------------------------------------------------------------------------
DOCKER_USER ?= yamlio

#------------------------------------------------------------------------------

all:
	docker build -t $(DOCKER_USER)/yaml-editor .

run:
	yaml-editor '/-(pegex|pm|syck|tiny|xs)\.|nim/'

#clean:
#	rm -f cjson pegex-pm ruamel test-base-pm testml-pm *yaml* *YAML*
#	rm -fr build

