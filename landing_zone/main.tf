terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.0"
    }
    azuread = {
      version = "1.6.0"
      source  = "hashicorp/azuread"
    }
  }
}
provider "azurerm" {
  features {}
}

locals {
  location = "australiaeast"
}

# create a resource group
resource "azurerm_resource_group" "packer_rg" {
  name     = "packer-images-rg"
  location = local.location
}

# create a resource group for image building
resource "azurerm_resource_group" "packer_temp_rg" {
  name     = "packer-temp-rg"
  location = local.location
}

# create a virtual network
resource "azurerm_virtual_network" "packer_vnet" {
  name                = "packer-vnet"
  resource_group_name = azurerm_resource_group.packer_rg.name
  location            = local.location
  address_space       = ["10.0.0.0/16"]
}

# create a subnet
resource "azurerm_subnet" "packer_subnet" {
  name                 = "packer-subnet"
  resource_group_name  = azurerm_resource_group.packer_rg.name
  virtual_network_name = azurerm_virtual_network.packer_vnet.name
  address_prefixes     = ["10.0.0.0/24"]
}


# create a shared image gallery
resource "azurerm_shared_image_gallery" "demo" {
  name                = "SharedImageGallery"
  resource_group_name = azurerm_resource_group.packer_rg.name
  location            = local.location
}


resource "azurerm_shared_image" "centos_7" {
  name                = "centos-7"
  resource_group_name = azurerm_resource_group.packer_rg.name
  gallery_name        = azurerm_shared_image_gallery.demo.name
  location            = local.location
  os_type             = "Linux"

  identifier {
    publisher = "VMnomad"
    offer     = "CentOS"
    sku       = "7.9"
  }
}


resource "azurerm_shared_image" "centos_6" {
  name                = "centos-6"
  resource_group_name = azurerm_resource_group.packer_rg.name
  gallery_name        = azurerm_shared_image_gallery.demo.name
  location            = local.location
  os_type             = "Linux"

  identifier {
    publisher = "VMnomad"
    offer     = "CentOS"
    sku       = "6.9"
  }
}
