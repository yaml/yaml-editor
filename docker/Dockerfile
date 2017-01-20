FROM ubuntu:16.04

RUN apt-get update \
 && apt-get install -y \
    autoconf \
    build-essential \
    cpanminus \
    entr \
    libtool \
    libyaml-dev \
    nodejs \
    npm \
    perl \
    python \
    python-pip \
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
 && pip install pyyaml \
 && true

COPY files/ /
ENV PATH="/yaml-editor/bin:/yaml-editor/sbin:/nim/bin:/filters:${PATH}" \
    NODE_PATH=/usr/local/lib/node_modules

RUN ( \
        cd /nim \
        && sh build.sh \
        && nim c koch \
        && ./koch tools \
        && ( yes | nimble install yaml ) \
    ) \
 && ( \
        nim compile /nimyaml_event.nim \
        && mv /nimyaml_event /usr/local/bin/nimyaml-event \
    ) \
 && mv /yaml2yeast /usr/local/bin/ \
 && true

RUN ( \
        git clone https://github.com/yaml/libyaml /libyaml \
        && cd /libyaml/tests/run-test-suite/src/ \
        && LIBYAML_DIR=/libyaml make build \
        && mv libyaml-parser /usr/local/bin \
        && mv libyaml-emitter /usr/local/bin \
    ) \
 && true

ENV PATH="/opt/rakudo-star-2016.11/bin:/opt/rakudo-star-2016.11/share/perl6/site/bin:${PATH}"
RUN wget http://rakudo.org/downloads/star/rakudo-star-2016.11.tar.gz \
 && tar xfz rakudo-star-2016.11.tar.gz \
 && ( \
        cd rakudo-star-2016.11 \
        && perl Configure.pl --gen-moar --prefix /opt/rakudo-star-2016.11 \
        && make install \
    ) \
 && panda update \
 && panda install YAMLish \
 && panda install Data::Dump \
 && true

WORKDIR /yaml
