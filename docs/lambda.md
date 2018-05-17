
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| description | the description to the lambda function | string | `a lambda function` | no |
| env_vars | environment variables to add to the function | map | `<map>` | no |
| handler | the name of the handler | string | - | yes |
| memory_size | the amount of memory to use | string | `128` | no |
| name | the name of the lambda function | string | - | yes |
| package_bucket | the bucket to write the lambda package too | string | - | yes |
| package_location | the s3 key where the lambda package is | string | - | yes |
| reserved_concurrent_executions | The number of concurrent lambda functions that can run (NOT CURRENTLY RESPECTED!) | string | `` | no |
| role | the lambda role to run as | string | - | yes |
| runtime | the runtime of the lambda function | string | - | yes |
| tags | tags to apply to the function | map | `<map>` | no |
| timeout | The amount of time your Lambda Function has to run in seconds. | string | `3` | no |
| vpc_security_group_ids | pass security group ids to run inside a VPC, must be used with vpc_subnet_ids | list | `<list>` | no |
| vpc_subnet_ids | pass subnets to run inside a VPC, must be used with vpc_security_group_ids | list | `<list>` | no |

## Outputs

| Name | Description |
|------|-------------|
| lambda_arn |  |
| lambda_name |  |

