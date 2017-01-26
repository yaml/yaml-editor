FROM haskell:8.0.1

RUN cabal update

ENV PATH=/work/yaml-editor/docker/bin:$PATH
