# This modules creates all the necessary services and resources to test the full trajectory of an event lifelycle
# from its creation until its consumption.

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

resource "aws_cloudwatch_event_rule" "console" {
  name           = "capture-aws-sign-in"
  event_bus_name = "default"
  description    = "Capture each AWS Console Sign In"

  event_pattern = file("${path.module}/../rules/console-login-event.json")
}

resource "aws_cloudwatch_event_target" "sns" {
  rule      = aws_cloudwatch_event_rule.console.name
  target_id = "SendToSNS"
  arn       = aws_sns_topic.aws_logins_notification.arn
}

resource "aws_sns_topic" "aws_logins_notification" {
  name = "aws-console-logins-sns"
}

resource "aws_sqs_queue" "aws_logins_queue" {
  name = "aws-console-logins-queue"
}

resource "aws_sns_topic_subscription" "user_updates_sqs_target" {
  topic_arn = aws_sns_topic.aws_logins_notification.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.aws_logins_queue.arn
}

resource "aws_sns_topic_policy" "default" {
  arn    = aws_sns_topic.aws_logins_notification.arn
  policy = data.aws_iam_policy_document.sns_topic_policy.json
}

data "aws_iam_policy_document" "sns_topic_policy" {
  statement {
    effect  = "Allow"
    actions = ["SNS:Publish"]

    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }

    resources = ["*"]
  }
}

resource "aws_sqs_queue_policy" "default" {
  queue_url = aws_sqs_queue.aws_logins_queue.id
  policy    = data.aws_iam_policy_document.sqs_queue_policy.json
}

data "aws_iam_policy_document" "sqs_queue_policy" {
  statement {
    effect  = "Allow"
    actions = ["SQS:SendMessage", ]

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    resources = ["*"]
  }
}


output "sqs_queue_url" {
  value = aws_sqs_queue.aws_logins_queue.id
}

output "sns_arn" {
  value = aws_sns_topic.aws_logins_notification.arn
}

output "pattern" {
  value = aws_cloudwatch_event_rule.console.event_pattern
}

output "bus" {
  value = aws_cloudwatch_event_rule.console.event_bus_name
}

output "rule_enabled" {
  value = var.enabled
}

output "input_path" {
  value = var.input_path
}

output "authored" {
  value = var.authored
}

output "environment" {
  value = var.environment
}

output "dependencies" {
  value = var.dependencies
}

