FROM ubuntu:16.04

RUN apt-get update \
 && apt-get install -y \
    git \
    nodejs \
    perl \
    python \
    ruby \
    vim \
 && true

COPY build/ /

ENV PATH="/yaml-editor/bin:/yaml-editor/sbin:/perl6/bin:${PATH}" \
    PERL5LIB=/lib/perl5

WORKDIR /yaml
