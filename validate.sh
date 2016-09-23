#!/bin/bash

set -e

errorOnFmt=${1:-false}

function fmtAndValidate() {
  local filesChanged=$(terraform fmt .)

  if [ ! -z "$filesChanged" ] && [ "$errorOnFmt" == true ]; then
    echo "formatting errors found"
    return 1
  fi

  terraform validate .
}

fmtAndValidate
