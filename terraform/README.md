<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_create_lambda_package"></a> [create_lambda_package](#module_create_lambda_package) | terraform-aws-modules/lambda/aws | 4.1.1 |
| <a name="module_get_transcription_lambda"></a> [get_transcription_lambda](#module_get_transcription_lambda) | terraform-aws-modules/lambda/aws | 4.1.1 |
| <a name="module_reciever_lambda"></a> [reciever_lambda](#module_reciever_lambda) | terraform-aws-modules/lambda/aws | 4.1.1 |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_event_rule.transcribe-notify](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.transcribe-lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_lambda_permission.allow_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_lambda_permission.eventbridge](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_s3_bucket.bucket1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_notification.bucket_notification](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_notification) | resource |
| [aws_s3_bucket_public_access_block.bucket1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_versioning.bucket1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [aws_sns_topic.notify](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |
| [aws_sns_topic_subscription.email](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |
| [aws_iam_policy_document.get_transcription_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.receiver_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_env"></a> [env](#input_env) | n/a | `string` | `"sbx"` | no |
| <a name="input_runtime"></a> [runtime](#input_runtime) | n/a | `string` | `"python3.9"` | no |
| <a name="input_timeout"></a> [timeout](#input_timeout) | n/a | `number` | `60` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket-name"></a> [bucket-name](#output_bucket-name) | n/a |
| <a name="output_reciever-lambda-arn"></a> [reciever-lambda-arn](#output_reciever-lambda-arn) | n/a |
<!-- END_TF_DOCS -->