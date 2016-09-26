provider "aws" {
  region = "us-east-1"
}

data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "test_bucket" {
  bucket = "tf-versioned-lambda-${data.aws_caller_identity.current.account_id}"
}

resource "aws_iam_role" "my_lambda_role" {
  name = "tf_versioned_lambda_test"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "log_perms" {
  name = "log_perms"
  role = "${aws_iam_role.my_lambda_role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "logs:*"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "read_only_s3" {
  name = "emr_readOnlyS3_policy"
  role = "${aws_iam_role.my_lambda_role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:Get*",
        "s3:List*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

output "role_arn" {
  value = "${aws_iam_role.my_lambda_role.arn}"
}

output "s3_bucket" {
  value = "${aws_s3_bucket.test_bucket.id}"
}
