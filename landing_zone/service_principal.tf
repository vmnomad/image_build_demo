data "azurerm_subscription" "current" {
}

# Create Application
resource "azuread_application" "packer" {
  display_name = "packer"
}


# Create Service Principal linked to the Application
resource "azuread_service_principal" "packer_spn" {
  application_id = azuread_application.packer.application_id
}

# Create role assignment for Service Principal
resource "azurerm_role_assignment" "contributor" {
  scope                = data.azurerm_subscription.current.id
  role_definition_name = "Contributor"
  principal_id         = azuread_service_principal.packer_spn.id
}

# Create Application password (client secret)
resource "azuread_application_password" "password" {
  application_object_id = azuread_application.packer.object_id
  end_date_relative     = "4320h" # expire in 6 months
}

output "client_id" {
  value = azuread_application.packer.application_id
}

output "client_secret" {
  value     = azuread_application_password.password.value
  sensitive = true
}