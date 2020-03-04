terraform {
  required_version = ">= 0.12"
}

variable "region" {
  default = "eu-central-1"
}

provider "aws" {
  region = var.region
}

data "aws_caller_identity" "current" {
}

resource "aws_s3_bucket" "test_bucket" {
  bucket = "tf-versioned-lambda-${data.aws_caller_identity.current.account_id}-${var.region}"
}

output "s3_bucket" {
  value = aws_s3_bucket.test_bucket.id
}

