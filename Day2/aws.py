import boto3
import botocore
import os
from config import S3_BUCKET, LOCAL_FILE, OBJECT_NAME
from logger import get_logger

logger = get_logger(__name__)
def upload_to_s3(Localfile,s3bucketname,object_name):
    if not os.path.exists(Localfile):
        logger.error(f"File does not exist:{Localfile}")

    s3 = boto3.client("s3")

    try:
        s3.upload_file(Localfile,s3bucketname,object_name)
        logger.info(f"Upload successful : {Localfile} -> s3/{s3bucketname}/{object_name}")
    except botocore.exceptions.ClientError as e:
        logger.error(f"upload failed: {e}")
    except Exception as e:
        logger.error("Unexpected error occured during upload")


if __name__ == "__main__":
    upload_to_s3(LOCAL_FILE, S3_BUCKET, OBJECT_NAME)
