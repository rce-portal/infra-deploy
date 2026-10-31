output "web_instance_ids" {
  value = aws_instance.web[*].id
}

output "db_instance_id" {
  value = aws_instance.db.id
}

output "backups_bucket" {
  value = aws_s3_bucket.backups.bucket
}
