def handler(event, context):
    return {
        "statusCode": 200,
        "headers": {"Content-Type": "text/plain"},
        "body": "Hello World from Lambda in Python!"
    }
