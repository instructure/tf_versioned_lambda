#!/bin/bash

set -e
CURDIR=$(pwd)
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

die () {
  echo >&2 "$@"
  exit 1
}

if [ -z ${AWS_ACCESS_KEY_ID+x} ]; then
  die "must have AWS_ACCESS_KEY_ID set"
fi

if [ -z ${AWS_SECRET_ACCESS_KEY+x} ]; then
  die "must have AWS_SECRET_ACCESS_KEY set"
fi

lambdaName=$1
lambdaDir=$2
lambdaDest=$3
jarFile=$4
configContents=$5
echo "building docker container"
mytmpdir=`mktemp -d 2>/dev/null || mktemp -d -t 'lambda'`
sourceDir=$(realpath ${CURDIR}/${lambdaDir})
cd $mytmpdir
cp -r $DIR/* .
cp -r $sourceDir/* .

echo "$configContents" > config.json
docker build \
  -f Dockerfile.lambda.sc \
  -t lambda_builder_${lambdaName} \
  --build-arg LAMBDA_DEST=${lambdaDest} \
  --build-arg JAR_PATH=${jarFile} \
  --build-arg CONFIG_FILE_DEST=${CONFIG_FILE_DEST} \
  --build-arg SBT_TASK_NAME=${SBT_TASK_NAME} \
  . || die "failed to build image"

echo "running docker container to build and upload lambda"
docker run \
  -e AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} \
  -e AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY} \
  lambda_builder_${lambdaName} || die "failed to run image"
rm -rf $mytmpdir
