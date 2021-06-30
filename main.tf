# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.26"
    }
  }

  backend "remote" {
    organization = "Sharknet"
    workspaces {
      name = "Azure_Tutorial"
    }
  }

  required_version = ">= 0.14.9"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = "westeurope"
  tags = {
      Environment = "Terraform Getting Started"
      Team = "DevOps"
      }
}

# Create a virtual network
/* resource "azurerm_virtual_network" "vnet" {
    name                = "myTFVnet"
    address_space       = ["10.10.10.0/24"]
    location            = "westeurope"
    resource_group_name = azurerm_resource_group.rg.name
} */

# Create a Test Container Group
resource "azurerm_container_group" "TerraformTestKjell" {
  name                = "terraformtestkjell"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  ip_address_type     = "public"
  dns_name_label      = "aci-label"
  os_type             = "Linux"

  container {
    name   = "hello-world"
    image  = "microsoft/aci-helloworld:latest"
    cpu    = "0.5"
    memory = "1.5"

    ports {
      port     = 443
      protocol = "TCP"
    }
  }

  container {
    name   = "sidecar"
    image  = "microsoft/aci-tutorial-sidecar"
    cpu    = "0.5"
    memory = "1.5"
  }
}