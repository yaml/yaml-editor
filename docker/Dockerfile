FROM ubuntu:16.04

RUN apt-get update \
 && apt-get install -y curl \
 && curl -sL https://deb.nodesource.com/setup_8.x | bash \
 && apt-get install -y nodejs
RUN apt-get update \
 && apt-get install -y \
    curl \
    default-jre-headless \
    gist \
    git \
    jq \
    locales \
    perl \
    python \
    python-pip \
    ruby \
    vim \
 && pip install ruamel.yaml \
 && locale-gen en_US.UTF-8 \
 && curl -sL https://deb.nodesource.com/setup_8.x | bash \
 && apt-get install -y luajit nodejs \
 && npm install -g coffee-script \
 && true

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
