#!/bin/bash

# # # # # # # #   Service Testing  # # # # # # # #   
#
# Service or integration tests within Terraform are tests that utilise multiple modules that work together, some of which
# may have dependencies on each other.
# Integration tests generally go through the following stages (imagine you have two Terraform modules):
# Build resources for module 1, 2, 3 and so on. Then run validations to make sure everything is working.
# In the end destroy resources for modules 1, 2 and 3.
# Remember — integration testing mean you have to provision the resources!
#
# Tools: Terraform and Terratest Go libraries

go test -v -run TestEventArchitectureComponents
#go test -v