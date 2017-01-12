FROM ubuntu:16.04

RUN apt-get update \
 && apt-get install -y \
        autoconf \
        build-essential \
        entr \
        libtool \
        nodejs \
        perl \
        python \
        ruby \
        wget \
        gist git tig vim \
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

COPY . /

RUN apt-get install -y wget \
 && cd nim \
 && sh build.sh \
 && export PATH="${PWD}/bin:${PATH}" \
 && nim c koch \
 && ./koch tools \
 && ( yes | nimble install yaml ) \
 && true

ENV PATH="/yaml-editor/bin:/nim/bin:${PATH}"

RUN nim compile /nim_events.nim \
 && mv /nim_events /usr/local/bin/nim-events \
 && true

WORKDIR /yaml-editor
