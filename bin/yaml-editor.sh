#!/bin/bash

set -e

file=test.yaml

if [[ $1 == CHECK ]]; then
  cd /tmp/yaml-editor
  while [[ ! -e DONE ]]; do
    sleep 0.05
  done
  rm DONE
  sleep 0.1
  exit 0
fi

if [[ $# -gt 0 ]]; then
  export RUN_LIST="$@"
  root="$(cd $(dirname $0)/..; pwd)"
  run="$root/bin/$(basename $0)"

  if [[ -e /tmp/entr.pid ]]; then
    kill $(cat /tmp/entr.pid) || true
    rm /tmp/entr.pid
  fi

  rm -fr /tmp/yaml-editor
  mkdir /tmp/yaml-editor
  cd /tmp/yaml-editor

  cp "$root/share/vimrc" .vimrc

  cp "$root/share/help" $file

  out=()
  for arg; do
    if [[ ! $arg =~ ^((lib|js-)yaml|nim-events|perl-(pegex|pm|xs))$ ]]; then
      echo "Invalid YAML framework: '$arg'."
      exit 1
    fi
    out+=("$arg.out")
  done

  (echo $file | entr $run) &> log &
  echo $! > /tmp/entr.pid

  vim -c 'source .vimrc' $file "${out[@]}" -O

elif [[ -z $RUN_LIST ]]; then
  cat <<...

You need to specify a list of YAML frameworks. Use these:

  libyaml     - libyaml Parser
  nim-events  - NimYAML Events
  perl-pm     - Perl's YAML.pm Loader
  perl-xs     - Perl's YAML::XS Loader
  perl-pegex  - Perl's YAML::Pegex Parser
  python      - Python's PyYAML Loader
  js-yaml     - Javascript's js-yaml Parser

...
  exit 1
fi

for yaml in $RUN_LIST; do
  cat $file | $yaml &> $yaml.out || true
done

touch DONE
