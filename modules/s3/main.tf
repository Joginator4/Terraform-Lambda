output "s3_bucket_trigger_id" {
  value = aws_s3_bucket.trigger-bucket.id
}

output "s3_bucket_trigger_arn" {
  value = aws_s3_bucket.trigger-bucket.arn
}