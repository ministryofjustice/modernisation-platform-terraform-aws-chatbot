output "aws_chatbot_slack_channel_arn" {
  value = awscc_chatbot_slack_channel_configuration.this.arn
}
output "aws_chatbot_iam_role" {
  value = awscc_iam_role.this.arn
}

output "random_suffix" {
  value = random_string.this.result
}
