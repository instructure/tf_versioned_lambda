
## Inputs

| Name | Description | Default | Required |
|------|-------------|:-----:|:-----:|
| name |  | - | yes |
| package_bucket | the bucket to write the lambda package too | - | yes |
| package_prefix | the prefix to use in the s3 bucket for writing lambda packages | `"lambda_packages"` | no |
| lambda_dir | the absolute path to the lambda directory you want to upload (must have a package.json) | - | yes |
| config_string | a json string that will get written as 'config.json' into the package | `"{}"` | no |
| handler | the name of the handler | - | yes |
| role | the lambda role to run as | - | yes |
| description | the description to the lambda function | `"a lambda function"` | no |
| memory_size | the amount of memory to use | `"512"` | no |
| runtime | the runtime of the lambda function | `"java8"` | no |
| config_dest | the location to write the conig file, generally the root of the resoures dir | `"src/main/resources/config.json"` | no |
| sbt_task | the sbt task to run | `"assembly"` | no |
| output_jar_path | the path of the jar written by sbt to upload | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| lambda_arn |  |
| lambda_name |  |

