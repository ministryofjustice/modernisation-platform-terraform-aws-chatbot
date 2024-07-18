package main

import (
	"regexp"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestModule(t *testing.T) {
	t.Parallel()

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "./unit-test",
	})

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

	awsChatbotSlackConfig := terraform.Output(t, terraformOptions, "aws_chatbot_slack_channel_arn")
	awsChatbotIamRole := terraform.Output(t, terraformOptions, "aws_chatbot_iam_role")
	randomSuffix := terraform.Output(t, terraformOptions, "random_suffix")

	assert.Regexp(t, regexp.MustCompile(`^arn:aws:iam::[0-9]{12}:role/chatBot-channel-role-`+randomSuffix), awsChatbotIamRole)
	assert.Regexp(t, regexp.MustCompile(`^arn:aws:chatbot::[0-9]{12}:chat-configuration/slack-channel/slack-channel-config-`+randomSuffix), awsChatbotSlackConfig)

}
