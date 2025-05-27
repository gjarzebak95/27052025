output "api_url" {
  description = "The URL to invoke the API"
  value       = "${module.api_gateway.apigatewayv2_api_api_endpoint}/upload"
}