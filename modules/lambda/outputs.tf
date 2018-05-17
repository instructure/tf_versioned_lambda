output "lambda_arn" {
  value = "${element(coalescelist(aws_lambda_function.lambda.*.arn, aws_lambda_function.lambda_vpc.*.arn), 0)}"
}

output "lambda_name" {
  value = "${element(coalescelist(aws_lambda_function.lambda.*.function_name, aws_lambda_function.lambda_vpc.*.function_name), 0)}"
}
