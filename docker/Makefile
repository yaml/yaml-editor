PERL5_YAML_PM := build/lib/perl5/YAML.pm
PERL5_YAML_XS := build/lib/perl5/x86_64-linux-gnu-thread-multi/YAML/LibYAML.pm
PERL5_YAML_TINY := build/lib/perl5/YAML/Tiny.pm
PERL5_YAML_SYCK := build/lib/perl5/YAML/Syck.pm
PERL5_YAML_PEGEX := build/lib/perl5/YAML/Pegex.pm
# PERL5_YAML_PP := build/lib/perl5/YAML/PP.pm
PERL5_MODULES := \
    $(PERL5_YAML_PM) \
    $(PERL5_YAML_XS) \
    $(PERL5_YAML_TINY) \
    $(PERL5_YAML_SYCK) \
    $(PERL5_YAML_PEGEX) \

#     $(PERL5_YAML_PP) \

PERL6_RUNTIME := build/bin/perl6
PERL6_YAMLISH := build/lib/YAMLish.pm6
PERL6_MODULES := $(PERL6_YAMLISH)
NIM_BINARIES := build/bin/nimyaml-event
LIBYAML_BINARIES := build/bin/libyaml-parser build/bin/libyaml-emitter

# xxx: build/bin nim-binaries
# 	docker build -t yamlio/yaml-editor .
# 	yaml-editor -v nimyaml.event

all: \
    build/bin \
    perl5-modules \
    perl6-runtime \
    perl6-modules \
    nim-binaries \
    libyaml-binaries
	docker build -t yamlio/yaml-editor .

run:
	yaml-editor -v '/-(pegex|pm|syck|tiny|xs)\.|nim/'

build/bin:
	mkdir -p $@

perl5-modules: builder-perl5 $(PERL5_MODULES)
perl6-runtime: builder-perl6 $(PERL6_RUNTIME)
perl6-modules: builder-perl6 $(PERL6_MODULES)
nim-binaries: builder-nim $(NIM_BINARIES)
libyaml-binaries: builder $(LIBYAML_BINARIES)

$(PERL5_YAML_PM): yaml-pm test-base-pm
	docker run --rm -v $$PWD:/work builder-perl5 perl5-modules $<
	touch $@

$(PERL5_YAML_XS): yaml-libyaml-pm test-base-pm
	docker run --rm -v $$PWD:/work builder-perl5 perl5-modules $<
	touch $@

$(PERL5_YAML_TINY): YAML-Tiny
	docker run --rm -v $$PWD:/work builder-perl5 perl5-modules $<
	touch $@

$(PERL5_YAML_SYCK): YAML-Syck
	docker run --rm -v $$PWD:/work builder-perl5 perl5-modules $<
	touch $@

$(PERL5_YAML_PEGEX): yaml-pegex-pm pegex-pm testml-pm
	docker run --rm -v $$PWD:/work builder-perl5 perl5-modules $<
	touch $@

# $(PERL5_YAML_PP): YAML-PP-p5
# 	docker run --rm -v $$PWD:/work builder-perl5 perl5-modules $<
# 	touch $@

$(PERL6_RUNTIME):
	docker run --rm -v $$PWD:/work builder-perl6 perl6-runtime
	touch $@

$(PERL6_YAMLISH): yamlish
	docker run --rm -v $$PWD:/work builder-perl6 perl6-modules $<
	touch $@

$(NIM_BINARIES): src/nimyaml_event.nim
	docker run --rm -it -v $$PWD:/work builder-nim nim-compile $< $@

$(LIBYAML_BINARIES): libyaml
	docker run --rm -it -v $$PWD:/work builder libyaml-compile $< $@

builder:
	docker build -t $@ -f $@.dockerfile .

builder-%: builder
	docker build -t $@ -f $@.dockerfile .

# Copy repos from local dev sources:
%: ../../%
	cp -pr $< $@
	touch $@

../../libyaml:
	git clone git@github.com:yaml/libyaml $@

../../yaml-pm ../../yaml-libyaml-pm ../../yaml-pegex-pm ../../pegex-pm ../../testml-pm ../../test-base-pm:
	git clone git@github.com:ingydotnet/yaml-libyaml-pm $@

../../YAML-Tiny:
	git clone git@github.com:Perl-Toolchain-Gang/YAML-Tiny $@

../../YAML-Syck:
	git clone git@github.com:toddr/YAML-Syck $@

# ../../YAML-PP-p5:
# 	git clone git@github.com:perlpunk/YAML-PP-p5 $@

../../yamlish:
	git clone git@github.com:leont/yamlish $@

clean:
	rm -fr build/ libyaml/ pegex-pm/ test-base-pm/ testml-pm/ yaml* YAML*
