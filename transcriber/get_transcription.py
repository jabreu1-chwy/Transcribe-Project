import boto3
import os
import requests

transcribe = boto3.client("transcribe")
sns = boto3.client("sns")

topic = os.environ["NOTIFY_SNS_TOPIC"]


def lambda_handler(event, context):
    job_name = event["detail"]["TranscriptionJobName"]
    print(event)

    response = transcribe.get_transcription_job(TranscriptionJobName=job_name)

    fileuri = response["TranscriptionJob"]["Transcript"]["TranscriptFileUri"]
    get_uri_contents = requests.get(fileuri).json()
    transcript = get_uri_contents["results"]["transcripts"][0]["transcript"]

    response = sns.publish(
        TopicArn=topic, Message=transcript, Subject="SNS Notification"
    )


# {
#     "version": "0",
#     "id": "ba35ee98-9744-4c5a-e2ea-00e081b24f93",
#     "detail-type": "Transcribe Job State Change",
#     "source": "aws.transcribe",
#     "account": "594227135020",
#     "time": "2022-12-07T20:46:14Z",
#     "region": "us-east-1",
#     "resources": [],
#     "detail": {
#         "TranscriptionJobName": "15d02565-2ebf-42a0-8773-bd271668c20c",
#         "TranscriptionJobStatus": "COMPLETED"
#     }
# }
