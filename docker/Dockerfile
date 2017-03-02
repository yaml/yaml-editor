FROM ubuntu:16.04

RUN apt-get update \
 && apt-get install -y \
    default-jre-headless \
    gist \
    git \
    jq \
    nodejs \
    npm \
    perl \
    python \
    python-pip \
    ruby \
    vim \
 && ( \
        ln /usr/bin/nodejs /usr/bin/node \
        && npm install -g coffee-script \
    ) \
 && pip install ruamel.yaml \
 && locale-gen en_US.UTF-8 \
 && true

RUN apt-get install -y luajit

COPY build/ /

ENV PATH="/yaml-editor/bin:/perl6/bin:${PATH}" \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8 \
    NODE_PATH=/node_modules \
    PERL5LIB=/lib/perl5 \
    PYTHONPATH=/lib/python2.7/site-packages

WORKDIR /yaml

# Set the locale
