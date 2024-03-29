
locals {
  build_script = coalesce(
    var.build_script,
    format("%s/files/build_docker.sh", path.module),
  )
  build_sbt_sha = filesha1(format("%s/build.sbt", var.lambda_dir))
  s3_key = format(
    "%s/%s_%s.jar",
    var.package_prefix,
    var.name,
    sha1(format("%s%s", var.config, local.build_sbt_sha)),
  )
  s3_location = format("s3://%s/%s", var.package_bucket, local.s3_key)
}

data "aws_region" "current" {}

resource "null_resource" "inject_build" {
  triggers = {
    config_val    = var.config
    build_sbt_sha = local.build_sbt_sha
  }

  provisioner "local-exec" {
    command = "${local.build_script} ${var.name} ${var.lambda_dir} '${local.s3_location}' ${var.output_jar_path} '${var.config}'"

    environment = {
      AWS_DEFAULT_REGION = data.aws_region.current.name
      AWS_REGION         = data.aws_region.current.name
      CONFIG_FILE_DEST   = var.config_dest
      SBT_TASK_NAME      = var.sbt_task
      SOURCE_REPO        = format("%s/files/", path.module)
    }
  }
}

# this is a bit of a hack, we use this resource to depend on build_upload resource
# and then rely on an output from this file, this ensures that any dependencies
# happen after build_upload has finished
resource "aws_s3_object" "finished_upload" {
  depends_on = [null_resource.inject_build]
  bucket     = var.package_bucket
  key        = replace(local.s3_key, ".jar", ".finished")
  content    = local.build_sbt_sha
}

