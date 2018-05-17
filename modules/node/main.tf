module "build" {
  source = "../node_build"

  name           = "${var.name}"
  build_script   = "${var.build_script}"
  config         = "${coalesce(var.config, var.config_string, "{}")}"
  lambda_dir     = "${var.lambda_dir}"
  package_bucket = "${var.package_bucket}"
  package_prefix = "${var.package_prefix}"
}

module "lambda" {
  source = "../lambda"

  package_bucket   = "${var.package_bucket}"
  package_location = "${module.build.s3_key}"

  name                           = "${var.name}"
  handler                        = "${var.handler}"
  role                           = "${var.role}"
  runtime                        = "${var.runtime}"
  description                    = "${var.description}"
  memory_size                    = "${var.memory_size}"
  timeout                        = "${var.timeout}"
  reserved_concurrent_executions = "${var.reserved_concurrent_executions}"
  vpc_subnet_ids                 = "${var.vpc_subnet_ids}"
  vpc_security_group_ids         = "${var.vpc_security_group_ids}"
  env_vars                       = "${var.env_vars}"
  tags                           = "${var.tags}"
}
