# Placeholder for the module variables

variable "name" {
  type        = string
  default     = ""
  description = "Name "
}

variable "application" {
  type        = string
  default     = ""
  description = "Application name (e.g. xapp)."
}

variable "environment" {
  type        = string
  default     = "dev"
  description = "Environment (e.g. `prod`, `dev`, `staging`)."
}

variable "authored" {
  type        = string
  default     = "evisb"
  description = "Authored by"
}

variable "dependencies" {
  type        = string
  default     = ""
  description = "External dependencies of the module."
}

variable "enabled" {
  type        = bool
  default     = true
  description = "Whether the rule should be enabled (defaults to true)."
}

variable "description" {
  type        = string
  default     = ""
  description = "The description for the rule."
}

variable "input_path" {
  type        = string
  default     = "rules/"
  description = "The value of the JSONPath that is used for extracting part of the matched event when passing it to the target."
}