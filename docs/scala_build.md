
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| build_script | allow for passing a custom build script, which overrides default build_docker.sh | string | `` | no |
| config | a json blob that will get written as 'config.json' into the package | string | `{}` | no |
| config_dest | the location to write the conig file, generally the root of the resoures dir | string | `src/main/resources/config.json` | no |
| lambda_dir | the absolute path to the lambda directory you want to upload (must have a package.json) | string | - | yes |
| name | the name of the lambda function | string | - | yes |
| output_jar_path | the path of the jar written by sbt to upload | string | - | yes |
| package_bucket | the bucket to write the lambda package too | string | - | yes |
| package_prefix | the prefix to use in the s3 bucket for writing lambda packages | string | `lambda_packages` | no |
| sbt_task | the sbt task to run | string | `assembly` | no |

## Outputs

| Name | Description |
|------|-------------|
| s3_key |  |
| s3_location |  |

