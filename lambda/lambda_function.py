import json
import boto3
import base64
import os

def handler(event, context):
    s3 = boto3.client('s3')
    bucket_name = os.environ['BUCKET_NAME']
    
    try:
        body = json.loads(event['body'])
        file_content = base64.b64decode(body['file_content'])
        file_name = body.get('file_name', 'uploaded_file.txt')
        
        s3.put_object(Bucket=bucket_name, Key=file_name, Body=file_content)
        
        return {
            'statusCode': 200,
            'body': json.dumps({'message': f'File {file_name} uploaded successfully to S3'})
        }
    except Exception as e:
        return {
            'statusCode': 500,
            'body': json.dumps({'error': str(e)})
        }
