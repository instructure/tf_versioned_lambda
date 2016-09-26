provider "aws" {
  region = "us-east-1"
}

data "aws_caller_identity" "current" {}

module "my_lambda" {
  source          = "../../modules/scala"
  name            = "tf_version_demo_scala"
  role            = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/tf_versioned_lambda_test"
  handler         = "helloworld.Main::sayHello"
  package_bucket  = "tf-versioned-lambda-${data.aws_caller_identity.current.account_id}"
  package_prefix  = "tf_versioned/builds"
  lambda_dir      = "files/hello_world"
  config_string   = "{\"name\": \"From Scala\"}"
  output_jar_path = "target/scala-2.11/lambda.jar"
}
