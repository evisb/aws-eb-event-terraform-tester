#!/bin/bash

# # # # # # #    Static testing    # # # # # # #  

# ###### Static code analysis
# 
# Hashicorp provides you with a way to perform syntax validation with the command — terraform validate. This tool allows for a 
# quick test to make sure you have not made mistake with spellings, syntax, or checking for unused variables.
cd ../../modules/
terraform validate -json 


# ###### Linting
#
# Linters will analyse code for programmatic or stylistic errors. They can pick up errors that would otherwise not be picked
# up by other methods of static testing. # An example of this would be for provider-specific fields/resources. 
# It contains at the moment a aws rulset consisting of 700+ rules.
# You can get this tool from: https://github.com/terraform-linters/tflint
TFLINT_LOG=debug tflint | grep watch


# ###### Security checking
#
# tfsec uses static analysis of your terraform templates to detect potential security flaws and recommend improvements.
# Make sure to install the tool from https://github.com/tfsec/tfsec/releases or directly from the 
# source: go get -u github.com/tfsec/tfsec/cmd/tfsec
tfsec .