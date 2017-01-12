FROM ubuntu:16.04

RUN apt-get update \
 && apt-get install -y \
        autoconf \
        build-essential \
        entr \
        libtool \
        perl \
        python \
        ruby \
        nodejs \
        gist git tig vim \
 && mkdir /build \
 && true

RUN apt-get install -y cpanminus \
 && cpanm \
        Pegex \
        IO::All \
        YAML \
        YAML::XS \
        YAML::Tiny \
        YAML::Syck \
 && true

RUN git clone https://github.com/yaml/libyaml /libyaml \
 && ( \
        cd /libyaml/tests/run-test-suite/src/; \
	LIBYAML_DIR=$PWD/../../.. make build; \
	mv libyaml-parser /usr/local/bin; \
    ) \
 && true

COPY yaml-pegex-pm /build/yaml-pegex-pm

RUN apt-get install -y wget \
 && cd / \
 && wget http://nim-lang.org/download/nim-0.16.0.tar.xz \
 && tar xJf nim-0.16.0.tar.xz \
 && cd nim-0.16.0 \
 && sh build.sh \
 && export PATH="${PWD}/bin:${PATH}" \
 && nim c koch \
 && ./koch tools \
 && ( yes | nimble install yaml ) \
 && true
ENV PATH="/yaml-editor/bin:/nim-0.16.0/bin:${PATH}"
COPY nim_events.nim /build/nim_events.nim
RUN nim compile /build/nim_events.nim \
 && mv /build/nim_events /usr/local/bin/nim-events \
 && true

# COPY build.sh /build/build.sh
# WORKDIR /build
# RUN ./build.sh

WORKDIR /yaml-editor
