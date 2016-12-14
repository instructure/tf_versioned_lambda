resource "null_resource" "inject_build" {
  triggers {
    config_val    = "${var.config_string}"
    build_sbt_sha = "${sha1(file(format("%s/build.sbt", var.lambda_dir)))}"
  }

  provisioner "local-exec" {
    command = "SBT_TASK_NAME=${var.sbt_task} CONFIG_FILE_DEST=${var.config_dest} ${format("%s/files/build_docker.sh", path.module)} ${var.name} ${var.lambda_dir} ${format("s3://%s/%s/%s_%s.jar", var.package_bucket, var.package_prefix, var.name, sha1(format("%s%s", var.config_string, sha1(file(format("%s/build.sbt", var.lambda_dir))))))} ${var.output_jar_path} '${var.config_string}'"
  }
}

resource "aws_lambda_function" "lambda" {
  depends_on = ["null_resource.inject_build"]
  s3_bucket  = "${var.package_bucket}"
  s3_key     = "${var.package_prefix}/${var.name}_${sha1(format("%s%s", var.config_string, sha1(file(format("%s/build.sbt", var.lambda_dir)))))}.jar"

  # work around https://github.com/hashicorp/terraform/issues/5673
  s3_object_version = "null"
  function_name     = "${var.name}"
  handler           = "${var.handler}"
  role              = "${var.role}"
  runtime           = "${var.runtime}"
  description       = "${var.description}"
  memory_size       = "${var.memory_size}"
  timeout           = "${var.timeout}"

  vpc_config = {
    subnet_ids         = "${var.vpc_subnet_ids}"
    security_group_ids = "${var.vpc_security_group_ids}"
  }

  environment {
    variables = "${var.environment_variables}"
  }
}
