#!/bin/bash

set -e

docker build -t tf_versioned_lambda:docs .
docker run -v $(pwd)/docs:/app/docs -t tf_versioned_lambda:docs /app/gen_docs.sh
