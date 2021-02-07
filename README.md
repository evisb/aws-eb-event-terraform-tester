# aws-eb-event-terraform-tester

A suite for testing AWS Event Bridge event payloads and constructs

## Description

This is a suite to run **static** tests on event payloads like *static analysis*, *linting* and *vulnerability testing* as well **dynamic** tests for AWS EventBridge constructs and events such as *payload*, service *and* *end-2-end* testing.

## Prerequisites

It is assumed that [Go](https://golang.org/doc/install), [aws-cli v2](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html), [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli), [tflint](https://github.com/terraform-linters/tflint) and [tfsec](https://tfsec.dev/docs/home/) are installed and correctly configured in your PATH.

## How to run

You can either invoke the Makefile in the root direcory to run all tests or alternatively run the respective runTests.sh script in each test directory to run tests separately
