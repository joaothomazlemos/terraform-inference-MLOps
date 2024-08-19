import boto3
import json




def lambda_handler(event, context):
    #send a unique sns message when the lambda is triggered
    topic_arn = "arn:aws:sns:us-east-1:667854778706:autoencoder_anomaly_alarm_test_debug"
    sns = boto3.client('sns')
    sns.publish(
        TopicArn=topic_arn,
         Message="Hello from Lambda IMAGE! We are in production now! Are we?!...?!??."
    )
    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda IMAGE! We are in production now! Are we!,,,?!')
    }