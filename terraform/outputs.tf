output "bucket-name" {
  value = aws_s3_bucket.bucket1.bucket
}

output "reciever-lambda-arn" {
  value = module.reciever_lambda.lambda_function_arn
}

