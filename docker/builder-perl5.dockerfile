FROM yamlio/builder

RUN apt-get install -y \
        cpanminus \
        perl

RUN cpanm -n Zilla::Dist
RUN cpanm -n \
        Spiffy \
 && true

RUN ( \
        git clone https://github.com/Perl-Toolchain-Gang/YAML-Tiny && \
        cd YAML-Tiny && \
        ( dzil authordeps --missing | cpanm -n ) \
    ) \
 && rm -fr YAML-Tiny \
 && true
