from elasticsearch import Elasticsearch
from datetime import datetime
import os

# Connect to Elasticsearch
# es = Elasticsearch([{'host': 'localhost', 'port': 9200}])  # Modify if remote
es = Elasticsearch([{'host': 'localhost', 'port': 9200, 'scheme': 'http'}])

def log_to_elk(metadata):
    """
    Logs upload metadata to Elasticsearch under 'uploads' index.
    """
    doc = {
        "filename": metadata["filename"],
        "s3_url": metadata["s3_url"],
        "ip": metadata["ip"],
        "upload_time": datetime.utcnow()
    }
    es.index(index="uploads", document=doc)
