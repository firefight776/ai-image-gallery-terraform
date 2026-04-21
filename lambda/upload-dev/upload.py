import boto3
import os
import json
import secrets

s3 = boto3.client("s3")

def lambda_handler(event, context):
    upload_bucket = os.environ["UPLOAD_BUCKET"]
    object_key = f"uploads/{secrets.token_urlsafe(12)}"
    content_type = event.get("queryStringParameters", {}).get("content-type", "binary/octet-stream")

    try:
        response = s3.generate_presigned_url(
            "put_object",
            Params={
                "Bucket": upload_bucket,
                "Key": object_key,
                "ContentType": content_type
            },
            ExpiresIn=3600
        )

        return {
            "statusCode": 200,
            "headers": {
                "Content-Type": "application/json"
            },
            "body": json.dumps({
                "upload_url": response,
                "object_key": object_key
            })
        }
    except Exception as e:
        print(f"Error generating pre-signed URL: {e}")
        return {
            "statusCode": 500,
            "headers": {
                "Content-Type": "application/json"
            },
            "body": json.dumps({"error": "Error generating pre-signed URL"})
        }