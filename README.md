# Terraform Module: Azure Secrets Engine

## Overview

This module enables and configures the Azure secrets engine for Vault.

## Example use case

On occasions when engineers require programmatic access to Azure, a service principal would normally be provisioned and securely distributed to them.  In these cases, these service principals are long-lived credentials, which, in the wrong hands, can cause a serious security incident.

Using the Vault Azure secrets engine drastically reduces the attack surface, as engineers request a short-lived credential from Vault, which is automatically deleted when the TTL expires.

Should these generated credentials get into the wrong hands, malicious actors would have significantly less time to exploit them.

## Usage

```hcl
provider "vault" {
  address = "http://localhost:8200"
  token   = var.vault_token
}

variable "vault_token" {}
variable "azure_subscription_id" {}
variable "azure_tenant_id" {}
variable "azure_client_id" {}
variable "azure_client_secret" {}

module "azure_defaults" {
  source          = "../../"

  azure_subscription_id = var.azure_subscription_id
  azure_tenant_id       = var.azure_tenant_id
  azure_client_id       = var.azure_client_id
  azure_client_secret   = var.azure_client_secret

  use_resource_group             = false
  azure_secret_backend_role_name = "test_role"
  azure_role                     = "owner"
}
```
## License

Licensed under the Apache License, Version 2.0 (the "License").

You may obtain a copy of the License at [apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0).

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an _"AS IS"_ basis, without WARRANTIES or conditions of any kind, either express or implied.

See the License for the specific language governing permissions and limitations under the License.