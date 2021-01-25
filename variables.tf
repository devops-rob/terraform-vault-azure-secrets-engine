variable "azure_subscription_id" {
  type        = string
  default     = "null"
  description = "(Required) Azure subscription ID."
}

variable "azure_tenant_id" {
  type        = string
  default     = null
  description = "(Required) Azure tenant ID."
}

variable "azure_client_id" {
  type        = string
  default     = null
  description = "(Required) Client ID for Azure Service Principal. WARNING - This will be written to the state file in plain text."
}

variable "azure_client_secret" {
  type        = string
  default     = null
  description = "(Required) Client secret for Azure Service Principal. WARNING - This will be written to the state file in plain text."
}

variable "azure_environment" {
  type        = string
  default     = "AzurePublicCloud"
  description = "(Optional) The Azure cloud environment to use."

  validation {
    condition     = can(contains(["AzurePublicCloud", "AzureUSGovernmentCloud", "AzureChinaCloud", "AzureGermanCloud"], var.azure_environment))
    error_message = "The Azure Environment value must be a valid identifier."
  }
}

variable "path" {
  type        = string
  default     = "azure"
  description = "(Required) The path that the secrets engine will be mounted to. Defaults to 'azure'."
}

variable "azure_secret_backend_role_name" {
  type        = string
  default     = null
  description = "(Required) Name for Azure secret backend role."
}

variable "azure_secret_backend_max_ttl" {
  type        = number
  default     = 3600
  description = "(Optional) Maximum TTL for Azure secret backend. Defaults to '3600'."
}

variable "azure_secret_backend_ttl" {
  type        = number
  default     = 3600
  description = "(Optional) Default TTL for Azure secret backend. Defaults to '3600'"
}

variable "use_resource_group" {
  type        = bool
  default     = false
  description = "(Optional) Toggle to enable usage of Resource Groups for Azure Role Scopes. When set to true, resource_group_identifier must be set. Defaults to 'false'."
}

variable "azure_role" {
  type        = string
  default     = "Reader"
  description = "(Optional) Azure role to assigned to service principal. Defaults to 'Reader'."

  validation {
    condition     = can(contains(["Reader", "Contributor", "Owner"], var.azure_role))
    error_message = "The Azure role must be one of Reader, Contributor, Owner."
  }

}

variable "resource_group_identifier" {
  type        = string
  default     = "null"
  description = "(Required when 'use_resource_group' is set to 'true') Azure Resource Group Identifier."
}

locals {
  global_identifier = "/subscription/${var.azure_subscription_id}"
  local_identifier  = "/subscription/${var.azure_subscription_id}/resourceGroups/${var.resource_group_identifier}"
  azure_role_scope  = var.use_resource_group ? local.local_identifier : local.global_identifier
}

variable "azure_app_id" {
  type        = string
  default     = null
  description = "(Optional) Application Object ID for an existing service principal that will be used instead of creating dynamic service principals. 'azure_roles' will be ignored if this is used."
}