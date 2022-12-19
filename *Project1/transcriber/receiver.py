import boto3
import uuid

client = boto3.client("transcribe")


def lambda_handler(event, context):
    bucket = event["Records"][0]["s3"]["bucket"]["name"]
    file = event["Records"][0]["s3"]["object"]["key"]
    bucket_path = f"s3://{bucket}/{file}"
    print(bucket_path)

    response = client.start_transcription_job(
        TranscriptionJobName=str(uuid.uuid4()),
        LanguageCode="en-US",
        Media={
            "MediaFileUri": bucket_path,
        },
    )
    print(response)
