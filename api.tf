module "api_gateway" {
  source  = "terraform-aws-modules/apigateway-v2/aws"
  version = "2.2.2"

  name          = var.api_name
  description   = "HTTP API Gateway for image upload service"
  protocol_type = "HTTP"

  create_api_domain_name = false

  cors_configuration = {
    allow_headers = ["content-type"]
    allow_methods = ["POST"]
    allow_origins = var.cors_allowed_origins
    max_age       = 300
  }

  # Routes and integrations
  integrations = {
    "POST /upload" = {
      integration_type       = "AWS_PROXY"
      integration_uri        = aws_lambda_function.image_upload.invoke_arn
      integration_method     = "POST"
      connection_type        = "INTERNET"
      payload_format_version = "2.0"
    }
  }

  # Stage
  default_stage_access_log_destination_arn = null
  default_stage_access_log_format          = null

  default_route_settings = {
    detailed_metrics_enabled = true
    throttling_burst_limit   = 100
    throttling_rate_limit    = 50
  }

  tags = {
    Name = var.api_name
  }
}

# Lambda permission for API Gateway
resource "aws_lambda_permission" "api_gw" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.image_upload.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${module.api_gateway.apigatewayv2_api_execution_arn}/*/*"
} 