# Modernisation Platform Terraform AWS ChatBot 

[![Standards Icon]][Standards Link] [![Format Code Icon]][Format Code Link] [![Scorecards Icon]][Scorecards Link] [![SCA Icon]][SCA Link] [![Terraform SCA Icon]][Terraform SCA Link]

A Terraform module to create an AWS ChatBot Slack channel configuration. This module allows you to set up AWS ChatBot in your Slack channels and subscribe to your SNS topics as required.

This offers an alternative to receiving alerts via PagerDuty as described in the Mod Platform [documentation](https://user-guide.modernisation-platform.service.justice.gov.uk/user-guide/integrating-alarms-with-pagerduty-with-slack.html#integrating-cloudwatch-alarms-with-pagerduty-and-slack).

It can be used in conjunction with any existing SNS topics to receive alerts directly to Slack and there is no extra cost for using the service!

You might want to use this for non-critical type events that don't need to be raised via PagerDuty e.g. receiving AWS health events, billing alerts or upcoming certificate expiry etc.

## Initial Setup Required

**Please note** that you need to manually setup the Slack client for each AWS account you wish to use with AWS Chatbot by following these steps: https://docs.aws.amazon.com/chatbot/latest/adminguide/slack-setup.html#slack-client-setup

Once this has been actioned you can create as many Slack channel configurations as required using this module.

## Usage

```hcl

module "template" {

  source = "github.com/ministryofjustice/modernisation-platform-terraform-aws-chatbot"

  slack_channel_id = "XXXXXXXXXXX"
  sns_topic_arns   = ["arn:aws:sns:eu-west-2:${local.environment_management.account_ids[terraform.workspace]}:<name-of-sns-topic>"]
  tags             = local.tags
  application_name = local.application_name

}

```

## Permissions

You can fine-tune the permissions available to AWS Chatbot so that you can control what users receiving the alerts in Slack can do (e.g. query log insights, raise support requests or even trigger lambda functions)

By default the module will assign the `arn:aws:iam::aws:policy/CloudWatchReadOnlyAccess` policy to the chatbot iam role. This ensures that users can see information in the alerts on slack for the various alarms that have been triggered etc. You can amend this by supplying an alternative value to the `managed_policy_arns` variable.  
For more detail on policies you may typically want to assign to the role read https://docs.aws.amazon.com/chatbot/latest/adminguide/chatbot-iam-policies.html  

By default this module will assign a Guardrail policy of `arn:aws:iam::aws:policy/ReadOnlyAccess`. This will constrain and take precedence over both user roles and channel roles. You can amend this by supplying an alternative value to the `guardrail_policies` variable.  
For more detail read https://docs.aws.amazon.com/chatbot/latest/adminguide/understanding-permissions.html#channel-guardrails   

<!--- BEGIN_TF_DOCS --->


<!--- END_TF_DOCS --->

## Looking for issues?
If you're looking to raise an issue with this module, please create a new issue in the [Modernisation Platform repository](https://github.com/ministryofjustice/modernisation-platform/issues).

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 6.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 6.0 |
| <a name="provider_random"></a> [random](#provider\_random) | ~> 3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_chatbot_slack_channel_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/chatbot_slack_channel_configuration) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [random_string.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_name"></a> [application\_name](#input\_application\_name) | Name of application | `string` | n/a | yes |
| <a name="input_guardrail_policies"></a> [guardrail\_policies](#input\_guardrail\_policies) | A list of IAM policy ARNs that are applied as channel guardrails | `list(string)` | <pre>[<br/>  "arn:aws:iam::aws:policy/ReadOnlyAccess"<br/>]</pre> | no |
| <a name="input_managed_policy_arns"></a> [managed\_policy\_arns](#input\_managed\_policy\_arns) | A list of policies arns to attach to the aws chatbot iam role as required | `list(string)` | <pre>[<br/>  "arn:aws:iam::aws:policy/CloudWatchReadOnlyAccess"<br/>]</pre> | no |
| <a name="input_slack_channel_id"></a> [slack\_channel\_id](#input\_slack\_channel\_id) | The Slack channel ID. Find the channel ID in Slack by right clicking on the channel in the channel list and copying the link. The channel ID is the string at the end of the URL. | `string` | n/a | yes |
| <a name="input_slack_team_id"></a> [slack\_team\_id](#input\_slack\_team\_id) | The Slack workspace ID. Defaults to Ministry of Justice Slack workspace | `string` | `"T02DYEB3A"` | no |
| <a name="input_sns_topic_arns"></a> [sns\_topic\_arns](#input\_sns\_topic\_arns) | ARNs of SNS topics which delivers notifications to AWS Chatbot, for example CloudWatch alarm notifications. | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Common tags to be used by all resources | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_chatbot_iam_role"></a> [aws\_chatbot\_iam\_role](#output\_aws\_chatbot\_iam\_role) | n/a |
| <a name="output_aws_chatbot_slack_channel_arn"></a> [aws\_chatbot\_slack\_channel\_arn](#output\_aws\_chatbot\_slack\_channel\_arn) | n/a |
| <a name="output_random_suffix"></a> [random\_suffix](#output\_random\_suffix) | n/a |
<!-- END_TF_DOCS -->

[Standards Link]: https://github-community.service.justice.gov.uk/repository-standards/modernisation-platform-terraform-aws-chatbot "Repo standards badge."
[Standards Icon]: https://github-community.service.justice.gov.uk/repository-standards/api/modernisation-platform-terraform-aws-chatbot/badge
[Format Code Icon]: https://img.shields.io/github/actions/workflow/status/ministryofjustice/modernisation-platform-terraform-aws-chatbot/format-code.yml?labelColor=231f20&style=for-the-badge&label=Formate%20Code
[Format Code Link]: https://github.com/ministryofjustice/modernisation-platform-terraform-aws-chatbot/actions/workflows/format-code.yml
[Scorecards Icon]: https://img.shields.io/github/actions/workflow/status/ministryofjustice/modernisation-platform-terraform-aws-chatbot/scorecards.yml?branch=main&labelColor=231f20&style=for-the-badge&label=Scorecards
[Scorecards Link]: https://github.com/ministryofjustice/modernisation-platform-terraform-aws-chatbot/actions/workflows/scorecards.yml
[SCA Icon]: https://img.shields.io/github/actions/workflow/status/ministryofjustice/modernisation-platform-terraform-aws-chatbot/code-scanning.yml?branch=main&labelColor=231f20&style=for-the-badge&label=Secure%20Code%20Analysis
[SCA Link]: https://github.com/ministryofjustice/modernisation-platform-terraform-aws-chatbot/actions/workflows/code-scanning.yml
[Terraform SCA Icon]: https://img.shields.io/github/actions/workflow/status/ministryofjustice/modernisation-platform-terraform-aws-chatbot/code-scanning.yml?branch=main&labelColor=231f20&style=for-the-badge&label=Terraform%20Static%20Code%20Analysis
[Terraform SCA Link]: https://github.com/ministryofjustice/modernisation-platform-terraform-aws-chatbot/actions/workflows/terraform-static-analysis.yml
