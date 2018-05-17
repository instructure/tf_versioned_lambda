variable "name" {
  description = "the name of the lambda function"
}

variable "build_script" {
  description = "allow for passing a custom build script, which overrides default build_docker.sh"
  default     = ""
}

variable "config" {
  description = "a json blob that will get written as 'config.json' into the package"
  default     = "{}"
}

variable "config_dest" {
  description = "the location to write the conig file, generally the root of the resoures dir"
  default     = "src/main/resources/config.json"
}

variable "lambda_dir" {
  description = "the absolute path to the lambda directory you want to upload (must have a package.json)"
}

variable "output_jar_path" {
  description = "the path of the jar written by sbt to upload"
}

variable "package_bucket" {
  description = "the bucket to write the lambda package too"
}

variable "package_prefix" {
  description = "the prefix to use in the s3 bucket for writing lambda packages"
  default     = "lambda_packages"
}

variable "sbt_task" {
  description = "the sbt task to run"
  default     = "assembly"
}
