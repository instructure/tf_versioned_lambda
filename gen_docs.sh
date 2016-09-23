#!/bin/bash

set -e

outDir=${1:-./docs}

function genDocs() {
  terraform-docs md . > "${outDir}/tf_versioned_lambda.md"
}

genDocs
