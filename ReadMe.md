yaml-editor
===========

Edit YAML and see it processed by various processors


# Synopsis

```
source .rc

# help
yaml-editor -h

# list supported frameworks
yaml-editor -l

# Open editor with four output windows in a grid
yaml-editor -g libyaml.event cpp.event pyyaml.event js-yaml.json
```

# Description

The editor will download the docker image
[yamlio/yaml-editor](https://hub.docker.com/r/yamlio/yaml-editor/) and start
a Vim session in it.

The Docker Image contains various YAML frameworks.

This repository also contains the code to create the docker image.
