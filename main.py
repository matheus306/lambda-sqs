import boto3

sqs = boto3.client('sqs', region_name="us-east-1")


def handler(event, context):
    print("#########################################################")
    print("Nós Somos Cruzeiro")
    print(event)
    return "ok"
