import boto3
import os
from dotenv import load_dotenv

# Load environment variables from .env
load_dotenv()

# Get AWS credentials and bucket name from environment
AWS_ACCESS_KEY_ID = os.getenv("AWS_ACCESS_KEY_ID")
AWS_SECRET_ACCESS_KEY = os.getenv("AWS_SECRET_ACCESS_KEY")
BUCKET = os.getenv("S3_BUCKET_NAME")

# Initialize the S3 client
s3 = boto3.client(
    's3',
    aws_access_key_id=AWS_ACCESS_KEY_ID,
    aws_secret_access_key=AWS_SECRET_ACCESS_KEY
)

def upload_to_s3(file):
    """
    Uploads a file object to S3 and returns the public URL.
    """
    s3.upload_fileobj(file, BUCKET, file.filename)
    return f"https://{BUCKET}.s3.amazonaws.com/{file.filename}"
