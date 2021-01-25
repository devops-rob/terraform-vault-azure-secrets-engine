resource "vault_azure_secret_backend" "azure_secret_backend" {
  path  = "azure"

  subscription_id = var.azure_subscription_id
  tenant_id       = var.azure_tenant_id

  client_id     = var.azure_client_id
  client_secret = var.azure_client_secret
  environment   = var.azure_environment
}

resource "vault_azure_secret_backend_role" "azure_secret_backend_role" {
  role  = var.azure_secret_backend_role_name

  backend = vault_azure_secret_backend.azure_secret_backend.path
  max_ttl = var.azure_secret_backend_max_ttl
  ttl     = var.azure_secret_backend_ttl

  azure_roles {
    role_name = var.azure_role
    scope     = local.azure_role_scope
  }

  application_object_id = var.azure_app_id
}
