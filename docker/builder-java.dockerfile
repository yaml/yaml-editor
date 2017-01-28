FROM maven:3-jdk-7

ENV PATH=/work/yaml-editor/docker/bin:$PATH

COPY java /snake2json

RUN apt-get update \
 && apt-get install -y \
        xmlstarlet \
        gist vim \
 && true
