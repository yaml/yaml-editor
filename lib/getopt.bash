#! bash

set -e

getopt() {
  local opt_spec="$(
    echo "$GETOPT_SPEC" |
      grep -A999999 '^--$' |
      grep -v '^\s*$' |
      tail -n+2
  )"
  GETOPT_DEFAULT_HELP="${GETOPT_DEFAULT_HELP:-true}"

  local help=false
  if $GETOPT_DEFAULT_HELP; then
    if [[ $# -eq 0 ]];then
      set -- --help
      help=true
    fi
  fi

  local rc=0
  local parsed="$(
    echo "$GETOPT_SPEC" |
    git rev-parse --parseopt -- "$@"
  )" || rc=$?

  if $help || [[ $rc -ne 0 ]]; then
    eval "$parsed" | pager
    exit $rc
  else
    eval "$parsed"
  fi

  while IFS= read line; do
    if [[ $line =~ ^([a-z]+)(,([a-z]+))?(=?)\  ]]; then
      if [[ -z ${BASH_REMATCH[4]} ]]; then
        opt_var="option_${BASH_REMATCH[1]}"
        if [[ -n ${BASH_REMATCH[3]} ]]; then
          opt_var="option_${BASH_REMATCH[3]}"
        fi
        printf -v $opt_var false
      fi
    fi
  done <<<"$opt_spec"

  while [ $# -gt 0 ]; do
    local option="$1"; shift

    if [[ $option == -x ]]; then
      set -x
      continue
    fi
    [[ $option != -- ]] || break

    local found=false line=
    while IFS= read line; do
      local wants_value=false match= opt_var=
      if [[ $line =~ ^([a-z]+)(,([a-z]+))?(=?)\  ]]; then
        if [[ "${#BASH_REMATCH[1]}" -gt 1 ]]; then
          match="--${BASH_REMATCH[1]}"
        else
          match="-${BASH_REMATCH[1]}"
        fi
        opt_var="option_${BASH_REMATCH[1]}"
        if [[ -n "${BASH_REMATCH[3]}" ]]; then
          opt_var="option_${BASH_REMATCH[3]}"
        fi
        if [[ -n "${BASH_REMATCH[4]}" ]]; then
          wants_value=true
        fi
      else
        die "Invalid GETOPT_SPEC option line: '$line'"
      fi

      if [[ $option == $match ]]; then
        if $wants_value; then
          printf -v $opt_var "$1"
          shift
        else
          printf -v $opt_var true
        fi
        found=true
        break
      fi
    done <<<"$opt_spec"

    $found || die "Unexpected option: '$option'"
  done

  local arg_name= arg_var= value= required=false array=false re1='^\+'
  for arg_name in $GETOPT_ARGS; do
    arg_var="${arg_name//-/_}"
    if [[ $arg_var =~ ^@ ]]; then
      array=true
      arg_var="${arg_var#@}"
    fi
    if [[ "$arg_var" =~ $re1 ]]; then
      required=true
      arg_var="${arg_var#+}"
    fi

    if [[ $# -gt 0 ]]; then
      if $array; then
        # XXX do this without eval:
        local str="$@"
        set -f
        eval "$arg_var=($@)"
        set +f
        set --
      else
        printf -v $arg_var "$1"
        shift
      fi
    fi
    if $required && [[ -z ${!arg_var} ]]; then
      die "'$arg_name' is required"
    fi
  done
  [ $# -eq 0 ] || die "Unexpected arguments: '$@'"
}

pager() {
  less -FRX
}

# vim: set ft=sh lisp:
