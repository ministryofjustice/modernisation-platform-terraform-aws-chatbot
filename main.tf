#------------------------------------------------------------------------------
# AWS CHATBOT SLACK CHANNEL CONFIGURATION
#------------------------------------------------------------------------------
// Creates a Slack channel configuration and associated IAM Role
// NOTE that you need to manually setup the Slack client for each AWS account following these steps: https://docs.aws.amazon.com/chatbot/latest/adminguide/slack-setup.html
// Once this has been actioned once per account you can subsequently create as many Slack channel configurations as required.

resource "aws_chatbot_slack_channel_configuration" "this" {
  configuration_name    = "slack-channel-config-${random_string.this.result}"
  iam_role_arn          = aws_iam_role.this.arn
  slack_channel_id      = var.slack_channel_id
  slack_team_id         = var.slack_team_id
  sns_topic_arns        = var.sns_topic_arns
  guardrail_policy_arns = var.guardrail_policies
}

// Creates a role for the AWS Chatbot - This defines what actions the Chatbot can perform within Slack.
resource "aws_iam_role" "this" {
  name = "chatBot-channel-role-${random_string.this.result}"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "chatbot.amazonaws.com"
        }
      },
    ]
  })
}
// Attach the AWS managed policies to the IAM role
resource "aws_iam_role_policy_attachment" "this" {
  for_each = toset(var.managed_policy_arns)

  role       = aws_iam_role.this.name
  policy_arn = each.value
}
// Create random suffix to ensure resource names are unique
resource "random_string" "this" {
  upper   = false
  special = false
  length  = 5
}