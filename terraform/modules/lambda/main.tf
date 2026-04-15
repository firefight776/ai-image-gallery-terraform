resource "aws_iam_role" "lambda_role" {
  name = "${var.project_name}-upload-lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name = "${var.project_name}-upload-lambda-role"
  }
}

resource "aws_iam_role_policy_attachment" "lambda_basic_logs" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy" "lambda_s3_policy" {
  name = "${var.project_name}-upload-lambda-s3-policy"
  role = aws_iam_role.lambda_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "UploadsBucketAccess"
        Effect = "Allow"
        Action = [
          "s3:PutObject"
        ]
        Resource = "arn:aws:s3:::${var.upload_bucket_name}/uploads/*"
      }
    ]
  })
}

resource "aws_lambda_function" "this" {
  function_name = var.lambda_function_name
  role          = aws_iam_role.lambda_role.arn
  handler       = "upload.lambda_handler"
  runtime       = "python3.12"
  filename      = var.lambda_zip_path
  timeout       = 10

  source_code_hash = filebase64sha256(var.lambda_zip_path)

  environment {
    variables = {
      UPLOAD_BUCKET = var.upload_bucket_name
    }
  }

  depends_on = [
    aws_iam_role_policy_attachment.lambda_basic_logs
  ]

  tags = {
    Name = var.lambda_function_name
  }
}

resource "aws_lambda_function_url" "this" {
  function_name      = aws_lambda_function.this.function_name
  authorization_type = "NONE"

  cors {
    allow_credentials = false
    allow_methods     = ["GET", "PUT", "POST"]
    allow_origins     = ["*"]
    allow_headers     = ["content-type"]
    expose_headers    = []
    max_age           = 86400
  }
}