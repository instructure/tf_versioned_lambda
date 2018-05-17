
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| build_script | allow for passing a custom build script, which overrides default build_docker.sh | string | `` | no |
| config | a json string that will get written as 'config.json' into the package | string | `` | no |
| config_dest | the location to write the conig file, generally the root of the resoures dir | string | `src/main/resources/config.json` | no |
| config_string | DEPRECATED, renamed 'config' | string | `` | no |
| description | the description to the lambda function | string | `a lambda function` | no |
| env_vars | environment variables to add to the function | map | `<map>` | no |
| handler | the name of the handler | string | `index.handler` | no |
| lambda_dir | the absolute path to the lambda directory you want to upload (must have a package.json) | string | - | yes |
| memory_size | the amount of memory to use | string | `512` | no |
| name | the name of the lambda function | string | - | yes |
| output_jar_path | the path of the jar written by sbt to upload | string | - | yes |
| package_bucket | the bucket to write the lambda package too | string | - | yes |
| package_prefix | the prefix to use in the s3 bucket for writing lambda packages | string | `lambda_packages` | no |
| reserved_concurrent_executions | The number of concurrent lambda functions that can run | string | `` | no |
| role | the lambda role to run as | string | - | yes |
| runtime | the runtime of the lambda function | string | `java8` | no |
| sbt_task | the sbt task to run | string | `assembly` | no |
| tags | tags to apply to the function | map | `<map>` | no |
| timeout | The amount of time your Lambda Function has to run in seconds. | string | `3` | no |
| vpc_security_group_ids | pass security group ids to run inside a VPC, must be used with vpc_subnet_ids | list | `<list>` | no |
| vpc_subnet_ids | pass subnets to run inside a VPC, must be used with vpc_security_group_ids | list | `<list>` | no |

## Outputs

| Name | Description |
|------|-------------|
| lambda_arn |  |
| lambda_name |  |
| s3_location |  |

