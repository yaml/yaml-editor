FROM ubuntu:16.04

RUN apt-get update \
 && apt-get install -y \
    autoconf \
    build-essential \
    cpio \
    libtool \
    libssh-dev \
    wget \
    gist git vim \
 && true

ENV PATH=/work/bin:$PATH
