package e2e

import (
	"strconv"
	"testing"

	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/sqs"

	"github.com/gruntwork-io/terratest/modules/logger"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestCompleteEventFlow(t *testing.T) {
	t.Parallel()

	// retryable errors in terraform testing.
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../../modules",
	})

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

	queueAddres := terraform.Output(t, terraformOptions, "sqs_queue_url")
	region := "us-east-1"
	eventGenerated := false

	// Create a SQS client.
	svc := sqs.New(session.Must(session.NewSession(&aws.Config{
		Region: aws.String(region)})))

	sqsQueueCycleLength := 20
	retries := 10

	for i := 0; i < retries; i++ {
		logger.Logf(t, "Waiting for message on %s (%ss)", queueAddres, strconv.Itoa(i*sqsQueueCycleLength))
		result, err := svc.ReceiveMessage(&sqs.ReceiveMessageInput{
			QueueUrl:              aws.String(queueAddres),
			AttributeNames:        aws.StringSlice([]string{"SentTimestamp"}),
			MaxNumberOfMessages:   aws.Int64(1),
			MessageAttributeNames: aws.StringSlice([]string{"All"}),
			WaitTimeSeconds:       aws.Int64(int64(sqsQueueCycleLength)),
		})

		if err != nil {
			t.Fatal(err)
		}

		if len(result.Messages) > 0 {
			eventGenerated = true
			logger.Logf(t, "Message %s received on %s", *result.Messages[0].Body, queueAddres)
			break
		}
	}
	if !eventGenerated {
		t.Fatal("No events generated.")
	}
}
