variable "tags" {
  type        = map(string)
  description = "Common tags to be used by all resources"
}
variable "application_name" {
  type        = string
  description = "Name of application"
}
# variable "slack_configuration_name" {
#   type        = string
#   description = "A name for the Slack channel configuration"
# }
variable "slack_channel_id" {
  type        = string
  description = "The Slack channel ID. Find the channel ID in Slack by right clicking on the channel in the channel list and copying the link. The channel ID is the string at the end of the URL."
}

variable "slack_workspace_id" {
  type        = string
  default     = "T02DYEB3A" //Defaults to Justice Digital Slack Workspace
  description = "The Slack workspace ID. Defaults to Ministry of Justice Slack workspace"
}

variable "sns_topic_arns" {
  type        = list(any)
  description = "ARNs of SNS topics which delivers notifications to AWS Chatbot, for example CloudWatch alarm notifications."
}

# variable "event_pattern" {
#   description = "Event pattern for CloudWatch Event Rule (defaults to AWS Health events)"
#   type        = string
#   default     = <<EOF
#   {
#   "source": ["aws.health"]
#   }
#   EOF
# }