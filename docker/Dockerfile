FROM ubuntu:16.04

RUN apt-get update \
 && apt-get install -y \
    git \
    nodejs \
    npm \
    perl \
    python \
    ruby \
    vim \
 && ( \
        ln /usr/bin/nodejs /usr/bin/node \
        && npm install -g coffee-script \
    ) \
 && true

COPY build/ /

ENV PATH="/yaml-editor/bin:/yaml-editor/sbin:/perl6/bin:${PATH}" \
    NODE_PATH=/node_modules \
    PERL5LIB=/lib/perl5 \
    PYTHONPATH=/lib/python2.7/site-packages

WORKDIR /yaml
