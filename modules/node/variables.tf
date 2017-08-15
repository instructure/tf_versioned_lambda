variable "name" {}

variable "package_bucket" {
  description = "the bucket to write the lambda package too"
}

variable "package_prefix" {
  description = "the prefix to use in the s3 bucket for writing lambda packages"
  default     = "lambda_packages"
}

variable "lambda_dir" {
  description = "the absolute path to the lambda directory you want to upload (must have a package.json)"
}

variable "config_string" {
  description = "a json string that will get written as 'config.json' into the package"
  default     = "{}"
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
  default     = "128"
}

variable "runtime" {
  description = "the runtime of the lambda function"
  default     = "nodejs4.3"
}

variable "timeout" {
  description = "The amount of time your Lambda Function has to run in seconds."
  default     = "3"
}

/* Not Working ATM
variable "vpc_subnet_ids" {
  description = "pass subnets to run inside a VPC, must be used with vpc_security_group_ids"
  default     = []
}

variable "vpc_security_group_ids" {
  description = "pass security group ids to run inside a VPC, must be used with vpc_subnet_ids"
  default     = []
}
*/

variable "build_script" {
  description = "allow for passing a custom build script, which overrides default build_docker.sh"
  default     = ""
}

variable "count" {
  default     = "1"
  description = "Passes through to terraform count."
}
