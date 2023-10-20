import urllib.parse
import boto3
import json
import logging


logging.basicConfig(level=logging.INFO)
s3 = boto3.client('s3')

def handler(event, context):
    event_body = event['Records'][0]
    bucket_name = event_body['s3']['bucket']['name']
    object_key = event_body['s3']['object']['key']
    key = urllib.parse.unquote_plus(object_key, encoding='utf-8')
    response = s3.get_object(Bucket=bucket_name, Key=key)
    file_output = response['Body'].read().decode()
    data = json.loads(file_output)
    transaction_field = data['Transactions']
    for transaction in transaction_field:
        print("Transaction Type:", transaction['transType'], ", ", "Amount:", transaction['amount'])
    return "OK"