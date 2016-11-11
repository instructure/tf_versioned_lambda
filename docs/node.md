
## Inputs

| Name | Description | Default | Required |
|------|-------------|:-----:|:-----:|
| name |  | - | yes |
| package_bucket | the bucket to write the lambda package too | - | yes |
| package_prefix | the prefix to use in the s3 bucket for writing lambda packages | `"lambda_packages"` | no |
| lambda_dir | the absolute path to the lambda directory you want to upload (must have a package.json) | - | yes |
| config_string | a json string that will get written as 'config.json' into the package | `"{}"` | no |
| handler | the name of the handler | `"index.handler"` | no |
| role | the lambda role to run as | - | yes |
| description | the description to the lambda function | `"a lambda function"` | no |
| memory_size | the amount of memory to use | `"128"` | no |
| runtime | the runtime of the lambda function | `"nodejs4.3"` | no |
| timeout | The amount of time your Lambda Function has to run in seconds. | `"3"` | no |
| vpc_subnet_ids | pass subnets to run inside a VPC, must be used with vpc_security_group_ids | - | yes |
| vpc_security_group_ids | pass security group ids to run inside a VPC, must be used with vpc_subnet_ids | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| lambda_arn |  |
| lambda_name |  |

