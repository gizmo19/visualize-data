variable "environment" {
  type        = string
  description = "Deployment environment name"
}

variable "aws_region" {
  type        = string
  description = "AWS region"
}

variable "raw_bucket_name" {
  type        = string
  description = "Name for raw data S3 bucket"
  default     = "steam-market-s3"
}

variable "raw_data_path" {
  type        = string
  description = "Path for raw data in S3 bucket"
  default     = "raw_data"
}

variable "processed_bucket_name" {
  type        = string
  description = "Name for processed data S3 bucket"
}

variable "lambda_memory_mb" {
  type        = number
  description = "Lambda memory size"
  default     = 256
}

variable "lambda_timeout_seconds" {
  type        = number
  description = "Lambda timeout in seconds"
  default     = 60
}

