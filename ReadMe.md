yaml-editor
===========

Edit YAML and see it processed by various processors


# Synopsis

```
source .rc
yaml-editor libyaml perl-pegex
yaml-editor -h # help
yaml-editor -l # list supported frameworks
```

# Description

The editor will download
[yamlio/yaml-editor](https://hub.docker.com/r/yamlio/yaml-editor/) and start
a Vim session in it.

The Docker Image contains various YAML frameworks.

This repository also contains the code to create the docker image.
