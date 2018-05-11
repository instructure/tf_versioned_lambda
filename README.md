# tf_versioned_lambda

A few terraform module that build and deploy lambda functions in a few languages

## Supported Languages
- nodejs
- scala

## Requirements
- Docker (for building the lambda function)
- AWS creds in your shell
- Your nodejs lambda code in a folder with a package.json at the folder root


## What it does
This module takes care of building your lambda function *during* a terraform run and
also knows when to update and redeploy it. That means you can have a single terraform
run that creates, deploys, and updates your lambas, which is much better than seperate steps
of building and deploying.

Since it uses docker to build your code, it also builds binary modules (in nodejs) properly regardless of
build environment (such as OSX)

## Example
Here is an example for the nodejs module
```
resource "aws_iam_role" "my_lambda_role" {
  name = "my_lambda_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "log_perms" {
  name = "log_perms"
  role = "${aws_iam_role.my_lambda_role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "logs:*"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "read_only_s3" {
  name = "emr_readOnlyS3_policy"
  role = "${aws_iam_role.my_lambda_role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:Get*",
        "s3:List*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_s3_bucket" "lambda_deploy" {
  bucket = "my-lambda-deploy-bucket"
}

module "my_lambda" {
  source         = "github.com/instructure/tf_versioned_lambda//modules/node"
  name           = "my_lambda"
  role           = "${aws_iam_role.my_lambda_role.arn}"
  handler        = "index.handler"
  runtime        = "nodejs10.x"
  package_bucket = "${aws_s3_bucket.lambda_deploy.id}"
  package_prefix = "myLambda/builds"
  lambda_dir     = "files/my_lambda_code"
  config_string  = <<EOF
  {"configKey": "someValue"}
EOF
}
```

Once again, its assumed that `files/my_lambda_code` is a proper npm module with a package.json at the root

## Docs
See `docs/*.md` for a full list of options for each language lambda

## How to update?
Updates are triggered when either the config has changed, or the build config (package.json for example)
inside the lambda changes.

This means if you want to deploy a new lambda, you should bump something like your version, which is nice
and might actually get you to version your code with semver

## How does it work?
- Uses a null resource that is triggered by hashes of the config and build config
- This null resource runs a provisioner that builds the lambda inside docker and uploads it to s3
- The terraform knows where the new s3 package should be and changes the lambda to point at it

## Config
Its pretty common pattern that you want to have multiple copies of a lambda running in different
environments with different config values. To make that easy, this exposes the ability to write a single
arbitrary blob of json which will be saved at the root of the lambda as `config.json`. Currently, this is the `config_string` variable
which is expected that you generate, but this may turn into being a terraform map in the future

##Transpiling/Compiling JS code
The docker build script runs npm install on code, so if you have a post-install npm script, you could
transpile your code using babel/typescript, whatever you like

## Ignoring some files in the build
If you want to avoid some files from being packaged into your zip file, you can place a `.lambdaignore`
file in the code directory and those files will not be included

## Custom Build Scripts
In some instances, you might need to do something slightly different in how you build your docker image, such as
passing custom `build-args` or volumes for caching. This is possible by passing a `build_script` variable that implements
the required functionality. It is generally expected to fork the existing files (found in `module/{node,scala}/files/build_docker.sh`).
Additionally, rather than using the `DIR` variable, an environment variable `SOURCE_REPO` is passed so that you can reference the existing files

See `examples/node` for an example

