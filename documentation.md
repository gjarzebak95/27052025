# Image Upload Service Documentation

Step-by-step instructions for setting up and using the image upload service that leverages AWS S3 for storage through an API Gateway and Lambda function.

## Prerequisites

- Git installed on your machine
- Terraform CLI installed (version 1.0.0 or later)
- AWS CLI installed and configured with appropriate credentials
- CURL or Postman for API testing

## Getting Started

### 1. Clone the Repository

```bash
git clone <repository-url>
cd 27052025
```

### 2. Deploy Infrastructure

The project uses Terraform to provision the required AWS infrastructure. Follow these steps to deploy:

1. Initialize Terraform:
```bash
terraform init
```

2. Review the planned changes:
```bash
terraform plan
```

3. Apply the infrastructure:
```bash
terraform apply
```

When prompted, type `yes` to confirm the deployment.

4. After successful deployment, note the API URL from the outputs:
```bash
terraform output api_url
```

This URL will be needed for uploading images.

## Using the Service

### Preparing Images for Upload

Before uploading an image, you need to convert it to base64 format. Here are different methods:

#### Using Linux/Mac:
```bash
base64 -i image.jpg -o image.b64
```

### Creating the Upload Payload

Create a JSON file (e.g., `payload.json`) with the following structure:
```json
{
  "file_name": "your-image-name.jpg",
  "file_content": "your-base64-encoded-image-content"
}
```

### Uploading Images

Use cURL to upload your image:
```bash
curl -X POST "YOUR_API_URL/upload" \
  -H "Content-Type: application/json" \
  -d @payload.json
```

Replace `YOUR_API_URL` with the API URL obtained from terraform output.

### Example Upload

1. Convert an image to base64:
```bash
base64 -i sheep.jpg -o sheep.b64
```

2. Create payload.json with the base64 content:
```json
{
  "file_name": "sheep.jpg",
  "file_content": "<content-from-sheep.b64>"
}
```

3. Upload using curl:
```bash
curl -X POST "https://your-api-url/upload" \
  -H "Content-Type: application/json" \
  -d @payload.json
```

## Cleaning Up

To remove all created resources from AWS:
```bash
terraform destroy
```

When prompted, type `yes` to confirm the deletion of resources.

## Troubleshooting

### Common Issues

1. **API Returns 500 Error**
   - Check if the Lambda function has proper permissions to access S3
   - Verify the S3 bucket exists and is accessible

2. **Invalid JSON Error**
   - Ensure your payload.json is properly formatted
   - Verify the base64 content doesn't contain newlines

3. **API Gateway Issues**
   - Verify the API URL is correct

### Logs and Debugging

- Lambda function logs can be found in CloudWatch Logs
- API Gateway logs can be enabled through the AWS Console

## Additional Resources

- [Terraform Documentation](https://www.terraform.io/docs)
- [AWS Lambda Documentation](https://docs.aws.amazon.com/lambda)
- [AWS API Gateway Documentation](https://docs.aws.amazon.com/apigateway)
- [AWS S3 Documentation](https://docs.aws.amazon.com/s3) 