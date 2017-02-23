#!/bin/bash

set -e

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

die () {
  echo >&2 "$@"
  exit 1
}

destS3Path=$LAMBDA_DEST
if [ -z "$destS3Path" ]; then
  die "missing lambda destination"
fi
ignoreFile=.lambdaignore
outFile=lambda.zip
cd $DIR
if [ -e $ignoreFile ]; then
  cat $ignoreFile | xargs zip -9qyr $outFile . -x
else
  zip -9qyr $outFile .
fi

aws configure set default.s3.signature_version s3v4
aws s3 cp $outFile $destS3Path
