provider "aws" {
  region = "us-east-1"
}

data "aws_caller_identity" "current" {}

module "my_lambda" {
  source         = "../../modules/node"
  name           = "tf_version_demo_node"
  role           = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/tf_versioned_lambda_test"
  handler        = "index.handler"
  runtime        = "nodejs8.10"
  package_bucket = "tf-versioned-lambda-${data.aws_caller_identity.current.account_id}"
  package_prefix = "tf_versioned/builds"
  lambda_dir     = "files/hello_world"
  build_script   = "files/custom_build_docker.sh"

  tags = {
    MyCustomTag = "foobar"
  }

  env_vars = {
    MyEnvVar = "foobar"
  }

  config = <<EOF
  {"name": "From Node"}
EOF
}
