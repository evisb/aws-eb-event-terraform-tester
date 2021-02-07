#!/bin/bash

# # # # # # #       End to End Testing      # # # # # # #
#
# End to end testing of EventBridge events payloads and construcs built with Terraform is testing all of your code and its behaviour 
# from beginning to end:
# Simulating event creation and emission, temporary cloud infrastructure resource deployment, event consumption and validation and resource destruction
# after the test completion.
# In most cases, you will be deploying this test in a staging environment or any prod-like environment to have a clear view of how the event patter and the 
# respective constructs would behave in production.
# In theory, you could use this test with any event patterns you'd store in the rules directory without changing a single line of code provided events are
# already being either emitted from an existing source or you can trigger the emission of an event on ad-hoc basis while running the test.
#
# Tools: Terraform, Terratest Go libraries

go test -v -run TestCompleteEventFlow -timeout 520s
#go test -v