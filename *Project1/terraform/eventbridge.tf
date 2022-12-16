resource "aws_cloudwatch_event_rule" "transcribe-notify" {
  name        = "joel-transcribe-notify"
  description = "Capture each transcribe job"

  event_pattern = <<EOF
{
  "source": ["aws.transcribe"],
  "detail-type": ["Transcribe Job State Change"],
  "detail": {
    "TranscriptionJobStatus": ["COMPLETED"]
  }
}
EOF
}

resource "aws_cloudwatch_event_target" "transcribe-lambda" {
  arn  = module.get_transcription_lambda.lambda_function_arn
  rule = aws_cloudwatch_event_rule.transcribe-notify.id
}

resource "aws_lambda_permission" "eventbridge" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = module.get_transcription_lambda.lambda_function_arn
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.transcribe-notify.arn
}