
module "create_lambda_package" {
  source                   = "terraform-aws-modules/lambda/aws"
  version                  = "4.1.1"
  create_function          = false
  create_package           = true
  recreate_missing_package = false
  runtime                  = var.runtime
  source_path = [
    {
      path          = "${path.root}/../transcriber",
      prefix_in_zip = "transcriber",
    }
    , {
      pip_requirements = "${path.root}/../requirements.txt"
    },
  ]
}

# -------------------------------------------------------------------------------------------------
# GET_ACCOUNTS Lambda
# -------------------------------------------------------------------------------------------------

#receiver.py
module "reciever_lambda" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "4.1.1"
  publish = true

  function_name = "joelabreu-receiver-lambda"
  description   = "lambda function recieves s3 notifications"
  handler       = "transcriber.receiver.lambda_handler"
  runtime       = var.runtime
  timeout       = var.timeout
  #layers                 = var.layers
  ephemeral_storage_size = null
  #lambda_role            = aws_iam_role.get_accounts_role.arn
  create_role = true

  create_package          = false
  local_existing_package  = module.create_lambda_package.local_filename
  ignore_source_code_hash = true
  policy_json             = data.aws_iam_policy_document.receiver_policy.json
  attach_policy_json      = true
}

#get_transcription.py
module "get_transcription_lambda" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "4.1.1"
  publish = true

  function_name = "joelabreu-get-transcription-lambda"
  description   = "lambda function pulls completed transcriptions"
  handler       = "transcriber.get_transcription.lambda_handler"

  runtime = var.runtime
  timeout = var.timeout
  # layers                 = [var.layers]
  ephemeral_storage_size = null
  #lambda_role            = aws_iam_role.get_accounts_role.arn
  create_role = true

  create_package          = false
  local_existing_package  = module.create_lambda_package.local_filename
  ignore_source_code_hash = true
  policy_json             = data.aws_iam_policy_document.get_transcription_policy.json
  attach_policy_json      = true
  environment_variables = {
    "NOTIFY_SNS_TOPIC" = aws_sns_topic.notify.arn
  }
}

