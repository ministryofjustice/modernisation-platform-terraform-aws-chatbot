#------------------------------------------------------------------------------
# AWS CHATBOT SLACK CHANNEL CONFIGURATION
#------------------------------------------------------------------------------
// Creates a Slack channel configuration. 
// NOTE that you need to manually setup the Slack client for each AWS account following these steps: https://docs.aws.amazon.com/chatbot/latest/adminguide/slack-setup.html
// Once this has been actioned once per account you can subsequently create as many Slack channel configurations as required.

resource "awscc_chatbot_slack_channel_configuration" "this" {
  configuration_name = "slack-channel-config-${random_string.suffix.result}"
  iam_role_arn       = awscc_iam_role.this.arn
  slack_channel_id   = var.slack_channel_id
  slack_workspace_id = var.slack_workspace_id
  sns_topic_arns     = var.sns_topic_arns
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
  managed_policy_arns = ["arn:aws:iam::aws:policy/AWSResourceExplorerReadOnlyAccess", "arn:aws:iam::aws:policy/CloudWatchReadOnlyAccess"]
}

// Create random suffix to ensure resource names are unique
resource "random_string" "suffix" {
  upper   = false
  special = false
  length  = 5
}

#------------------------------------------------------------------------------
# EVENTBRIDGE RULE & TARGET
#------------------------------------------------------------------------------

# resource "aws_cloudwatch_event_rule" "this" {
#   name          = "monitor-aws-health-alerts"
#   description   = "Monitor AWS Health Alerts"
#   event_pattern = var.event_pattern
# }

# resource "aws_cloudwatch_event_target" "this" {
#   rule      = aws_cloudwatch_event_rule.this.name
#   target_id = "SendToSNS"
#   arn       = aws_sns_topic.this.arn
# }

#------------------------------------------------------------------------------
# SNS TOPIC & SUBSCRIPTION
#------------------------------------------------------------------------------
# resource "aws_sns_topic" "this" {
#   name = "aws-health-events"
# }

# resource "aws_sns_topic_policy" "this" {
#   arn    = aws_sns_topic.this.arn
#   policy = data.aws_iam_policy_document.sns_topic_policy.json
# }

# data "aws_iam_policy_document" "sns_topic_policy" {
#   statement {
#     effect  = "Allow"
#     actions = ["SNS:Publish"]

#     principals {
#       type        = "Service"
#       identifiers = ["events.amazonaws.com"]
#     }

#     resources = [aws_sns_topic.this.arn]
#   }
# }

# resource "aws_sns_topic_subscription" "this" {
#   topic_arn = aws_sns_topic.this.arn
#   protocol  = "email-json"
#   endpoint  = var.email
# }