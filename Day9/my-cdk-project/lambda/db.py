import os
import json
import boto3

dynamodb = boto3.resource("dynamodb")
table_name = os.environ["TABLE_NAME"]

table = dynamodb.Table(table_name)

def handler(event, context):
    # Simple GET and PUT logic
    method = event["httpMethod"]

    if method == "GET":
        resp = table.scan()
        return {
            "statusCode": 200,
            "body": json.dumps(resp.get("Items", []))
        }
    elif method == "POST":
        body = json.loads(event["body"])
        table.put_item(Item=body)
        return {"statusCode": 201, "body": "Item Created"}
