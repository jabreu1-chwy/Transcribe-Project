resource "aws_sns_topic" "notify" {
  name = "joel_transcribe_notify"
}

resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.notify.arn
  protocol  = "email"
  endpoint  = "jabreu1@chewy.com"
}