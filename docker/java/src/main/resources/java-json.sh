#!/usr/bin/env bash
set -e
SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
java -jar $SCRIPTPATH/snake2json-${project.version}-jar-with-dependencies.jar