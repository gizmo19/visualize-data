resource "aws_iam_role" "lambda_role" {
  name               = "${local.namespace}-transformer-role-${var.environment}"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = { Service = "lambda.amazonaws.com" },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy" "lambda_policy" {
  name = "${local.namespace}-transformer-policy-${var.environment}"
  role = aws_iam_role.lambda_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "S3ReadRaw",
        Effect = "Allow",
        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ],
        Resource = [
          local.raw_bucket.arn,
          "${local.raw_bucket.arn}/*"
        ]
      },
      {
        Sid    = "S3WriteProcessed",
        Effect = "Allow",
        Action = [
          "s3:PutObject"
        ],
        Resource = [
          "${aws_s3_bucket.processed.arn}/*"
        ]
      },
      {
        Sid    = "Logs",
        Effect = "Allow",
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "*"
      }
    ]
  })
}

