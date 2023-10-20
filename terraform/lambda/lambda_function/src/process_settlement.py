import urllib.parse
import boto3
import json


s3 = boto3.client('s3')

#disaster_recovery_bucket = 

def handler(event, context):
    bucket = event['Records'][0]['s3']['bucket']['name']
    key = urllib.parse.unquote_plus(event['Records'][0]['s3']['object']['key'], encoding='utf-8')
    response = s3.get_object(Bucket=bucket,Key=key)
    file_output = response['Body'].read().decode()
    data = json.loads(file_output)
    transaction_field = data['Transactions']
    for transaction in transaction_field:
        print("Transaction Type:", transaction['transType'], ", ", "Amount:", transaction['amount'])