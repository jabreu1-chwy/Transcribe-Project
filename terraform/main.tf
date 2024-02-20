resource "aws_s3_bucket" "bucket1" {
  bucket = "joel-bucket-093091-${var.env}"
}

resource "aws_s3_bucket_public_access_block" "bucket1" {
  bucket = aws_s3_bucket.bucket1.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "bucket1" {
  bucket = aws_s3_bucket.bucket1.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_lambda_permission" "allow_bucket" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = module.reciever_lambda.lambda_function_arn
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.bucket1.arn
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.bucket1.id

  lambda_function {
    lambda_function_arn = module.reciever_lambda.lambda_function_arn
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = "upload/"
  }

  depends_on = [aws_lambda_permission.allow_bucket]
}









