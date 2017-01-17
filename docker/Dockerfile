FROM ubuntu:16.04

COPY . /
ENV PATH="/yaml-editor/bin:/nim/bin:${PATH}"

RUN apt-get update \
 && apt-get install -y \
    autoconf \
    build-essential \
    cpanminus \
    entr \
    libtool \
    nodejs \
    npm \
    perl \
    python \
    ruby \
    wget \
    gist git tig vim \
 && ( \
        ln /usr/bin/nodejs /usr/bin/node \
        && npm install -g coffee-script js-yaml \
    ) \
 && cpanm -n \
    Pegex \
    IO::All \
    YAML \
    YAML::XS \
    YAML::Tiny \
    YAML::Syck \
 && ( \
        git clone https://github.com/yaml/libyaml /libyaml \
        && cd /libyaml/tests/run-test-suite/src/ \
        && LIBYAML_DIR=$PWD/../../.. make build \
        && mv libyaml-parser /usr/local/bin \
    ) \
 && ( \
        cd /nim \
        && sh build.sh \
        && nim c koch \
        && ./koch tools \
        && ( yes | nimble install yaml ) \
    ) \
 && ( \
        nim compile /nim_events.nim \
        && mv /nim_events /usr/local/bin/nim-events \
    ) \
 && true

WORKDIR /yaml-editor
