output "raw_bucket_name" {
  value       = local.raw_bucket.bucket
  description = "Raw data S3 bucket name"
}

output "processed_bucket_name" {
  value       = aws_s3_bucket.processed.bucket
  description = "Processed data S3 bucket name"
}

output "lambda_function_name" {
  value       = aws_lambda_function.transformer.function_name
  description = "Lambda function name"
}

output "ecr_repository_url" {
  value       = aws_ecr_repository.lambda.repository_url
  description = "ECR repository URL for Lambda image"
}

