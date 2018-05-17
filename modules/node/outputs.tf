output "lambda_arn" {
  value = "${module.lambda.lambda_arn}"
}

output "lambda_name" {
  value = "${module.lambda.lambda_name}"
}

output "s3_location" {
  value = "${module.build.s3_location}"
}
