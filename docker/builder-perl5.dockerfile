FROM builder

RUN apt-get install -y \
        cpanminus \
        perl

RUN cpanm -n Zilla::Dist
RUN cpanm -n \
        Spiffy \
        Dist::Zilla::Plugin::OverridePkgVersion \
        Dist::Zilla::Plugin::CopyFilesFromBuild \
        Dist::Zilla::Plugin::MetaProvides::Package \
        Dist::Zilla::Plugin::Test::Compile \
 && true

RUN ( \
        git clone https://github.com/Perl-Toolchain-Gang/YAML-Tiny && \
        cd YAML-Tiny && \
        ( dzil authordeps --missing | cpanm -n ) \
    ) \
 && rm -fr YAML-Tiny \
 && true
