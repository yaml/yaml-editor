PERL5_YAML_PM := build/lib/perl5/YAML.pm
PERL5_YAML_XS := build/lib/perl5/x86_64-linux-gnu-thread-multi/YAML/LibYAML.pm
PERL5_YAML_TINY := build/lib/perl5/YAML.pm
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

# xxx: build perl6-runtime perl6-modules
# 	docker build -t yamlio/yaml-editor .
# 	yaml-editor -v perl6.p6

all: \
    build \
    perl5-modules \
    perl6-runtime \
    perl6-modules
	docker build -t yamlio/yaml-editor .

run:
	yaml-editor -v '/-(pegex|pm|syck|tiny|xs)\./'

build:
	mkdir $@

perl5-modules: builder-perl5 $(PERL5_MODULES)
perl6-runtime: builder-perl6 $(PERL6_RUNTIME)
perl6-modules: builder-perl6 $(PERL6_MODULES)

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

builder:
	docker build -t $@ -f $@.dockerfile .

builder-perl5 builder-perl6: builder
	docker build -t $@ -f $@.dockerfile .

# Copy repos from local dev sources:
%: ../../%
	cp -pr $< $@
	touch $@

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
	rm -fr build/ test-base-pm/ yaml-libyaml-pm/ yaml-pm/ yamlish/
