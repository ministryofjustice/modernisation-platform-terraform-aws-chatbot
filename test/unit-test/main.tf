
module "chatbot_module_test" {
  source = "../../"

  slack_channel_id = "C02PFCG8M1R" // #modernisation-platform-low-priority-alarms
  sns_topic_arns   = ["arn:aws:sns:eu-west-2:${local.environment_management.account_ids["testing-test"]}:securityhub-alarms"]
  application_name = local.application_name
  tags             = local.tags
}
