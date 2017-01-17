FROM ubuntu:16.04

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
 && true

COPY files/ /
ENV PATH="/yaml-editor/bin:/yaml-editor/sbin:/nim/bin:${PATH}" \
    NODE_PATH=/usr/local/lib/node_modules

RUN ( \
        git clone https://github.com/yaml/libyaml /libyaml \
        && cd /libyaml/tests/run-test-suite/src/ \
        && LIBYAML_DIR=/libyaml make build \
        && mv libyaml-parser /usr/local/bin \
        && mv libyaml-emitter /usr/local/bin \
    ) \
 && ( \
        cd /nim \
        && sh build.sh \
        && nim c koch \
        && ./koch tools \
        && ( yes | nimble install yaml ) \
    ) \
 && ( \
        nim compile /nimyaml_tokens.nim \
        && mv /nimyaml_tokens /usr/local/bin/nimyaml-tokens \
    ) \
 && true

WORKDIR /yaml
