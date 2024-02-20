data "aws_iam_policy_document" "receiver_policy" {
  statement {
    sid = "1"

    actions = [
      "transcribe:StartTranscriptionJob",
    ]

    resources = [
      "*",
    ]
  }
  statement {
    sid = "2"

    actions = [
      "s3:GetObject",
    ]

    resources = [
      "${aws_s3_bucket.bucket1.arn}/*",
    ]
  }
}


data "aws_iam_policy_document" "get_transcription_policy" {
  statement {
    sid = "1"

    actions = [
      "transcribe:GetTranscriptionJob",
    ]

    resources = [
      "*",
    ]
  }
  statement {
    sid = "2"

    actions = [
      "s3:PutObject",
    ]

    resources = [
      "${aws_s3_bucket.bucket1.arn}/*",
    ]
  }
  statement {
    sid = "3"

    actions = [
      "sns:Publish",
    ]

    resources = [
      aws_sns_topic.notify.arn,
    ]
  }
}