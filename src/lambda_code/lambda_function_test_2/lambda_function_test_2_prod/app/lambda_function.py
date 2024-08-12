import boto3
import json




def lambda_handler():
    #send a unique sns message when the lambda is triggered
    topic_arn = "autoencoder_anomaly_alarm_test_debug"
    sns = boto3.client('sns')
    sns.publish(
        TopicArn=topic_arn,
         Message="Hello from Lambda IMAGE! We are in production now! Are we?!"
    )
    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda IMAGE! We are in production now! Are we??')
    }