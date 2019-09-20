FROM haskell:8.6.5

RUN apt-get update && apt-get install -y pkg-config

RUN cabal update

ENV PATH=/work/yaml-editor/docker/bin:$PATH
