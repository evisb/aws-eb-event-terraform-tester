package test

import (
	"strconv"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestEventArchitectureComponents(t *testing.T) {
	t.Parallel()

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../../modules",
	})

	// To clean up any resources that have been created, it executes 'terraform destroy' towards the end of the test
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	// To get the value of an output variable, run 'terraform output'
	sqs := terraform.Output(t, terraformOptions, "sqs_queue_url")
	sns := terraform.Output(t, terraformOptions, "sns_arn")
	eventPattern := terraform.Output(t, terraformOptions, "pattern")
	eventBus := terraform.Output(t, terraformOptions, "bus")
	ruleEnabled, err := strconv.ParseBool(terraform.Output(t, terraformOptions, "rule_enabled"))
	inputPath := terraform.Output(t, terraformOptions, "input_path")
	authored := terraform.Output(t, terraformOptions, "authored")
	environment := terraform.Output(t, terraformOptions, "environment")
	dependencies := terraform.Output(t, terraformOptions, "dependencies")

	// Check that we get back the outputs that we expect
	assert.Equal(t, eventBus, "default")
	assert.Contains(t, sns, "us-east-1:304955174079")
	assert.Contains(t, sqs, "us-east-1.amazonaws.com/304955174079")
	assert.Equal(t, eventPattern, "{\"detail-type\":[\"AWS Console Sign In via CloudTrail\"]}")
	assert.Equal(t, ruleEnabled, true)
	assert.Equal(t, inputPath, "rules/")
	assert.NotEmpty(t, authored)
	assert.NotEmpty(t, environment)
	assert.Empty(t, dependencies)
	assert.NoError(t, err)
}
