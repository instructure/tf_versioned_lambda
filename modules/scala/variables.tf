variable "name" {
  description = "the name of the lambda function"
}

variable "package_bucket" {
  description = "the bucket to write the lambda package too"
}

variable "handler" {
  description = "the name of the handler"
  default     = "index.handler"
}

variable "role" {
  description = "the lambda role to run as"
}

variable "description" {
  description = "the description to the lambda function"
  default     = "a lambda function"
}

variable "memory_size" {
  description = "the amount of memory to use"
  default     = "512"
}

variable "runtime" {
  description = "the runtime of the lambda function"
  default     = "java8"
}

variable "output_jar_path" {
  description = "the path of the jar written by sbt to upload"
}

variable "timeout" {
  description = "The amount of time your Lambda Function has to run in seconds."
  default     = "3"
}

variable "reserved_concurrent_executions" {
  description = "The number of concurrent lambda functions that can run"
  default     = ""
}

variable "vpc_subnet_ids" {
  description = "pass subnets to run inside a VPC, must be used with vpc_security_group_ids"
  type        = list(string)
  default     = []
}

variable "vpc_security_group_ids" {
  description = "pass security group ids to run inside a VPC, must be used with vpc_subnet_ids"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "tags to apply to the function"
  type        = map(string)
  default     = {}
}

variable "env_vars" {
  description = "environment variables to add to the function"
  type        = map(string)
  default     = {}
}

variable "package_prefix" {
  description = "the prefix to use in the s3 bucket for writing lambda packages"
  default     = "lambda_packages"
}

variable "lambda_dir" {
  description = "the absolute path to the lambda directory you want to upload (must have a package.json)"
}

variable "config_string" {
  description = "DEPRECATED, renamed 'config'"
  default     = ""
}

variable "config" {
  description = "a json string that will get written as 'config.json' into the package"
  default     = ""
}

variable "config_dest" {
  description = "the location to write the conig file, generally the root of the resoures dir"
  default     = "src/main/resources/config.json"
}

variable "sbt_task" {
  description = "the sbt task to run"
  default     = "assembly"
}

variable "build_script" {
  description = "allow for passing a custom build script, which overrides default build_docker.sh"
  default     = ""
}

