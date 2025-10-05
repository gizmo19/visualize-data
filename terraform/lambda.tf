data "archive_file" "transformer_zip" {
  type        = "zip"
  source_dir  = "${path.root}/../backend/transformer"
  output_path = "${path.module}/build/transformer.zip"
}

resource "aws_lambda_function" "transformer" {
  function_name    = "${local.namespace}-transformer-${var.environment}"
  role             = aws_iam_role.lambda_role.arn
  runtime          = "nodejs20.x"
  handler          = "index.handler"
  filename         = data.archive_file.transformer_zip.output_path
  source_code_hash = data.archive_file.transformer_zip.output_base64sha256
  memory_size      = var.lambda_memory_mb
  timeout          = var.lambda_timeout_seconds

  environment {
    variables = {
      RAW_BUCKET       = local.raw_bucket.bucket
      PROCESSED_BUCKET = aws_s3_bucket.processed.bucket
    }
  }
}

resource "aws_lambda_permission" "allow_s3_invoke" {
  statement_id  = "AllowExecutionFromS3"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.transformer.arn
  principal     = "s3.amazonaws.com"
  source_arn    = local.raw_bucket.arn
}

resource "aws_s3_bucket_notification" "raw_trigger" {
  bucket = local.raw_bucket.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.transformer.arn
    events              = ["s3:ObjectCreated:Put", "s3:ObjectCreated:CompleteMultipartUpload", "s3:ObjectCreated:Copy", "s3:ObjectCreated:Post"]
    filter_prefix       = "${var.raw_data_path}/"
  }

  depends_on = [aws_lambda_permission.allow_s3_invoke]
}

