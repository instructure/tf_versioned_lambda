variable "name" {
  description = "the name of the lambda function"
}

variable "package_bucket" {
  description = "the bucket to write the lambda package too"
}

variable "package_location" {
  description = "the s3 key where the lambda package is"
}

variable "handler" {
  description = "the name of the handler"
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
}

variable "timeout" {
  description = "The amount of time your Lambda Function has to run in seconds."
  default     = "3"
}

variable "reserved_concurrent_executions" {
  description = "The number of concurrent lambda functions that can run (NOT CURRENTLY RESPECTED!)"
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

