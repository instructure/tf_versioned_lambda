output "s3_location" {
  value = local.s3_location
}

output "s3_key" {
  value = replace(aws_s3_bucket_object.finished_upload.id, ".finished", ".jar")
}

