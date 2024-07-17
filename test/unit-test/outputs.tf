output "aws_chatbot_slack_channel_arn" {
  value = module.chatbot_module_test.aws_chatbot_slack_channel_arn
}
output "aws_chatbot_iam_role" {
  value = module.chatbot_module_test.aws_chatbot_iam_role
}

output "random_suffix" {
  value = module.chatbot_module_test.random_suffix
}
