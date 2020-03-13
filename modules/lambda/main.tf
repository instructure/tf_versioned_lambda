locals {
  default_tags = {
    Provisioner = "tf-versioned-lambda"
    Name        = "${var.name}"
  }

  merged_tags = "${merge(local.default_tags, var.tags)}"

  default_env = {
    CONFIG_FILE_NAME = "config.json"
  }

  merged_envs = "${merge(local.default_env, var.env_vars)}"
}

resource "aws_lambda_function" "lambda" {
  count     = "${length(var.vpc_subnet_ids) == 0 ? 1 : 0}"
  s3_bucket = "${var.package_bucket}"
  s3_key    = "${var.package_location}"

  runtime       = "${var.runtime}"
  function_name = "${var.name}"
  handler       = "${var.handler}"
  role          = "${var.role}"

  description = "${var.description}"
  memory_size = "${var.memory_size}"
  timeout     = "${var.timeout}"

  # not an easy way to have a sane default, disable for now
  #reserved_concurrent_executions = "${var.reserved_concurrent_executions}"

  environment {
    variables = "${local.merged_envs}"
  }
  tags   = "${local.merged_tags}"
  layers = "${var.layers}"
}

resource "aws_lambda_function" "lambda_vpc" {
  count     = "${length(var.vpc_subnet_ids) > 0 ? 1 : 0}"
  s3_bucket = "${var.package_bucket}"
  s3_key    = "${var.package_location}"

  runtime       = "${var.runtime}"
  function_name = "${var.name}_vpc"
  handler       = "${var.handler}"
  role          = "${var.role}"

  description = "${var.description}"
  memory_size = "${var.memory_size}"
  timeout     = "${var.timeout}"

  # not an easy way to have a sane default, disable for now
  #reserved_concurrent_executions = "${var.reserved_concurrent_executions}"

  vpc_config {
    subnet_ids         = "${var.vpc_subnet_ids}"
    security_group_ids = "${var.vpc_security_group_ids}"
  }
  environment {
    variables = "${local.merged_envs}"
  }
  tags = "${local.merged_tags}"
}
