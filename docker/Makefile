#------------------------------------------------------------------------------
BASE := $(shell cd ../..; pwd)
#------------------------------------------------------------------------------
DOCKER_USER ?= yamlio
CPP_BINARIES := build/bin/cpp-event
GHC_BINARIES := build/bin/yaml2yeast build/bin/hsyaml-event build/bin/hsyaml-json
LIBYAML_BINARIES := build/bin/libyaml-parser build/bin/libyaml-emitter
JAVA_BINARIES := \
    build/bin/java-json \
    build/bin/java-event
JAVA_SOURCES := \
    src/java/src/main/resources/java-json.sh \
    src/java/src/main/resources/java-event.sh \
    src/java/pom.xml \
    src/java/src/main/java/org/yaml/editor/Snake2Json.java \
    src/java/src/main/java/org/yaml/editor/Snake2Events.java
LUA_MODULES := \
    build/usr/local/share/lua/5.1/yaml/init.lua \
    build/usr/local/share/lua/5.1/cjson/util.lua
NIM_BINARIES := build/bin/nimyaml-event
NODE_MODULES := build/node_modules/js-yaml/lib/js-yaml.js
PERL5_YAML_PM := build/lib/perl5/YAML.pm
PERL5_YAML_XS := build/lib/perl5/x86_64-linux-gnu-thread-multi/YAML/LibYAML.pm
PERL5_YAML_TINY := build/lib/perl5/YAML/Tiny.pm
PERL5_YAML_SYCK := build/lib/perl5/YAML/Syck.pm
PERL5_YAML_PEGEX := build/lib/perl5/YAML/Pegex.pm
PERL5_YAML_PP := build/lib/perl5/YAML/PP.pm
PERL5_MODULES := \
    $(PERL5_YAML_PM) \
    $(PERL5_YAML_XS) \
    $(PERL5_YAML_TINY) \
    $(PERL5_YAML_SYCK) \
    $(PERL5_YAML_PEGEX) \
    $(PERL5_YAML_PP)
# ':' confuses `make` so use + to mean : and adjust later
CPAN_MODULES := \
    JSON++XS \
    JSON++PP
PERL6_RUNTIME := build/bin/perl6
PERL6_YAMLISH := build/lib/YAMLish.pm6
PERL6_MODULES := $(PERL6_YAMLISH)
PYTHON_MODULES := \
    build/lib/python2.7/site-packages/yaml/__init__.py \
    build/lib/python2.7/site-packages/ruamel/yaml/__init__.py

#------------------------------------------------------------------------------
# xxx: build/bin nim-binaries
# 	docker build -t yamlio/yaml-editor .
# 	yaml-editor nimyaml.event

all: \
    setup \
    cpp-binaries \
    ghc-binaries \
    libyaml-binaries \
    java-binaries \
    lua-modules \
    nim-binaries \
    node-modules \
    perl5-modules \
    perl5-runtime \
    perl6-runtime \
    perl6-modules \
    python-modules \
    vcs-info
	rm -fr build
	cp -r ../../build .
	docker build -t $(DOCKER_USER)/yaml-editor .

vcs-info:
	../bin/vcs-info-to-framework > ../../build/yaml-frameworks.csv
	cp ../share/emitters.csv ../../build/yaml-emitters.csv

run:
	yaml-editor '/-(pegex|pm|syck|tiny|xs)\.|nim/'

setup:
	mkdir -p ../../build/bin
	cp ../sbin/* ../../build/bin/
	rm -fr build
	ln -s ../../build

clean:
	rm -f cjson pegex-pm ruamel test-base-pm testml-pm *yaml* *YAML*
	rm -fr build

#------------------------------------------------------------------------------
cpp-binaries: builder-cmake $(CPP_BINARIES)
ghc-binaries: builder-ghc $(GHC_BINARIES)
libyaml-binaries: builder $(LIBYAML_BINARIES)
java-binaries: builder-java $(JAVA_BINARIES)
lua-modules: builder-lua $(LUA_MODULES)
nim-binaries: builder-nim $(NIM_BINARIES)
node-modules: builder-node $(NODE_MODULES)
perl5-modules: builder-perl5 $(PERL5_MODULES)
perl5-runtime: builder-perl5 $(CPAN_MODULES)
perl6-runtime: builder-perl6 $(PERL6_RUNTIME)
perl6-modules: builder-perl6 $(PERL6_MODULES)
python-modules: builder-python $(PYTHON_MODULES)

#------------------------------------------------------------------------------
$(CPP_BINARIES): yaml-cpp
	docker run --rm -v $(BASE):/work $(DOCKER_USER)/builder-cmake cpp-compile $<
	touch $@

$(GHC_BINARIES): yamlreference HsYAML
	docker run --rm -v $(BASE):/work $(DOCKER_USER)/builder-ghc ghc-compile $@
	touch $@

$(LIBYAML_BINARIES): libyaml
	docker run --rm -v $(BASE):/work $(DOCKER_USER)/builder libyaml-compile $<
	touch $@

$(JAVA_BINARIES): $(JAVA_SOURCES) snakeyaml
	docker run --rm -v $(BASE):/work $(DOCKER_USER)/builder-java java-compile $<
	touch $@

$(LUA_MODULES): lua-yaml
	docker run -it --rm -v $(BASE):/work $(DOCKER_USER)/builder-lua lua-modules $<
	touch $@

$(NIM_BINARIES): src/nimyaml_event.nim NimYAML
	docker run --rm -v $(BASE):/work $(DOCKER_USER)/builder-nim nim-compile $< $@
	touch $@

$(NODE_MODULES): js-yaml
	docker run --rm -v $(BASE):/work $(DOCKER_USER)/builder-node node-modules $<
	touch $@

$(CPAN_MODULES):
	docker run --rm -v $(BASE):/work $(DOCKER_USER)/builder-perl5 cpan-modules $@

$(PERL5_YAML_PM): yaml-pm test-base-pm
	docker run --rm -v $(BASE):/work $(DOCKER_USER)/builder-perl5 perl5-modules $<
	touch $@

$(PERL5_YAML_XS): yaml-libyaml-pm test-base-pm
	docker run --rm -v $(BASE):/work $(DOCKER_USER)/builder-perl5 perl5-modules $<
	touch $@

$(PERL5_YAML_TINY): YAML-Tiny
	docker run --rm -v $(BASE):/work $(DOCKER_USER)/builder-perl5 perl5-modules $<
	touch $@

$(PERL5_YAML_SYCK): YAML-Syck
	docker run --rm -v $(BASE):/work $(DOCKER_USER)/builder-perl5 perl5-modules $<
	touch $@

$(PERL5_YAML_PEGEX): yaml-pegex-pm pegex-pm testml-pm
	docker run --rm -v $(BASE):/work $(DOCKER_USER)/builder-perl5 perl5-modules $<
	touch $@

$(PERL5_YAML_PP): YAML-PP-p5
	docker run --rm -v $(BASE):/work $(DOCKER_USER)/builder-perl5 perl5-modules $<
	touch $@

$(PERL6_RUNTIME):
	docker run --rm -v $(BASE):/work $(DOCKER_USER)/builder-perl6 perl6-runtime $<
	touch $@

$(PERL6_YAMLISH): yamlish
	docker run --rm -v $(BASE):/work $(DOCKER_USER)/builder-perl6 perl6-modules $<
	touch $@

$(PYTHON_MODULES): pyyaml ruamel
	docker run --rm -v $(BASE):/work $(DOCKER_USER)/builder-python python-modules $@
	touch $@

builder:
	docker build -t $(DOCKER_USER)/$@ -f $@.dockerfile .
	docker tag $(DOCKER_USER)/$@ $@

builder-%: builder
	docker build -t $(DOCKER_USER)/$@ -f $@.dockerfile .

#------------------------------------------------------------------------------
# Copy repos from local dev sources:
%: ../../%
	ln -s $< $@
	touch $@/

#------------------------------------------------------------------------------
../../yamlreference:
	git clone git@github.com:orenbenkiki/$(@:../../%=%) $@

../../HsYAML:
	git clone git@github.com:hvr/$(@:../../%=%) $@

../../libyaml ../../pyyaml:
	git clone git@github.com:yaml/$(@:../../%=%) $@

../../js-yaml:
	git clone git@github.com:nodeca/$(@:../../%=%) $@

../../lua-yaml:
	git clone git@github.com:lubyk/yaml $@

../../NimYAML:
	git clone git@github.com:flyx/$(@:../../%=%) $@

../../ruamel:
	hg clone https://bitbucket.org/ruamel/yaml -u 0.14.4 $@

../../snakeyaml:
	hg clone https://bitbucket.org/asomov/$(@:../../%=%) $@

../../yaml-pm ../../yaml-libyaml-pm ../../yaml-pegex-pm ../../pegex-pm ../../testml-pm ../../test-base-pm:
	git clone git@github.com:ingydotnet/$(@:../../%=%) $@

../../YAML-PP-p5:
	git clone git@github.com:perlpunk/$(@:../../%=%) $@

../../YAML-Tiny:
	git clone git@github.com:Perl-Toolchain-Gang/$(@:../../%=%) $@

../../YAML-Syck:
	git clone git@github.com:toddr/$(@:../../%=%) $@

../../yaml-cpp:
	git clone https://github.com/jbeder/$(@:../../%=%) $@

../../yamlish:
	git clone git@github.com:leont/$(@:../../%=%) $@
