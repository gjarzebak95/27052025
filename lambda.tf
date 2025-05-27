locals {
  lambda_zip_path = "lambda/image_upload.zip"
}

resource "aws_lambda_function" "image_upload" {
  filename         = local.lambda_zip_path
  function_name    = var.lambda_function_name
  role             = aws_iam_role.lambda_s3_role.arn
  handler          = "lambda_function.handler"
  runtime          = var.lambda_runtime
  timeout          = var.lambda_timeout
  memory_size      = var.lambda_memory_size
  source_code_hash = filebase64sha256(local.lambda_zip_path)

  vpc_config {
    subnet_ids         = module.vpc.private_subnets
    security_group_ids = [aws_security_group.lambda_sg.id]
  }

  environment {
    variables = {
      BUCKET_NAME = module.s3_bucket.s3_bucket_id
    }
  }

  tags = {
    Name = var.lambda_function_name
  }
}

# Security Group for Lambda
resource "aws_security_group" "lambda_sg" {
  name        = var.security_group_name
  description = "Security group for Lambda function"
  vpc_id      = module.vpc.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.security_group_name
  }
}
