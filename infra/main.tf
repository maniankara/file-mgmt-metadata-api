# Fetch the existing resource group
data "azurerm_resource_group" "fsmgmt" {
  name = var.rg_name
}

# Container registry to store the images, public for now
resource "azurerm_container_registry" "fsmgmt" {
  name                = var.app_name
  resource_group_name = data.azurerm_resource_group.fsmgmt.name
  location            = data.azurerm_resource_group.fsmgmt.location
  sku                 = "Standard"
  admin_enabled       = true
}

# Service plan for the app service
resource "azurerm_service_plan" "fsmgmt" {
  name                = var.app_name
  resource_group_name = data.azurerm_resource_group.fsmgmt.name
  location            = data.azurerm_resource_group.fsmgmt.location
  os_type             = "Linux"
  sku_name            = "P1v2"
}

# The app itself, pulling image from ACR
resource "azurerm_linux_web_app" "fsmgmt" {
  name                = var.app_name
  resource_group_name = data.azurerm_resource_group.fsmgmt.name
  location            = azurerm_service_plan.fsmgmt.location
  service_plan_id     = azurerm_service_plan.fsmgmt.id

  site_config {
    application_stack {
      docker_image_name = var.app_name
      docker_registry_url = "https://${azurerm_container_registry.fsmgmt.login_server}"
      docker_registry_username = azurerm_container_registry.fsmgmt.admin_username
      docker_registry_password = azurerm_container_registry.fsmgmt.admin_password
    }
  }
}