output "aws_chatbot_slack_channel_arn" {
  value = aws_chatbot_slack_channel_configuration.this.chat_configuration_arn
}
output "aws_chatbot_iam_role" {
  value = aws_iam_role.this.arn
}

output "random_suffix" {
  value = random_string.this.result
}
