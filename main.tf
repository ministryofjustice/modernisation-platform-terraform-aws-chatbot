#------------------------------------------------------------------------------
# AWS CHATBOT SLACK CHANNEL CONFIGURATION
#------------------------------------------------------------------------------
// Creates a Slack channel configuration and associated IAM Role
// NOTE that you need to manually setup the Slack client for each AWS account following these steps: https://docs.aws.amazon.com/chatbot/latest/adminguide/slack-setup.html
// Once this has been actioned once per account you can subsequently create as many Slack channel configurations as required.

resource "awscc_chatbot_slack_channel_configuration" "this" {
  configuration_name = "slack-channel-config-${random_string.suffix.result}"
  iam_role_arn       = awscc_iam_role.this.arn
  slack_channel_id   = var.slack_channel_id
  slack_workspace_id = var.slack_workspace_id
  sns_topic_arns     = var.sns_topic_arns
  guardrail_policies = var.guardrail_policies
}

// Creates a role for the AWS Chatbot - This defines what actions the Chatbot can perform within Slack.
resource "awscc_iam_role" "this" {
  role_name = "chatBot-channel-role-${random_string.suffix.result}"
  assume_role_policy_document = jsonencode({
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
  managed_policy_arns = var.managed_policy_arns
}

// Create random suffix to ensure resource names are unique
resource "random_string" "suffix" {
  upper   = false
  special = false
  length  = 5
}