# S3 Variables
variable "bucket_name" {
  description = "Name of the S3 bucket for image uploads"
  type        = string
  default     = "27052025-image"
}
# Lambda Variables
variable "lambda_function_name" {
  description = "Name of the Lambda function"
  type        = string
  default     = "27052025-function"
}

variable "lambda_runtime" {
  description = "Runtime for the Lambda function"
  type        = string
  default     = "python3.9"
}

variable "lambda_memory_size" {
  description = "Memory size for the Lambda function in MB"
  type        = number
  default     = 256
}

variable "lambda_timeout" {
  description = "Timeout for the Lambda function in seconds"
  type        = number
  default     = 30
}

variable "cors_allowed_origins" {
  description = "List of allowed origins for CORS"
  type        = list(string)
  default     = ["*"]
}

# Security Group Variables
variable "security_group_name" {
  description = "Name of the Lambda security group"
  type        = string
  default     = "lambda_security_group"
} 