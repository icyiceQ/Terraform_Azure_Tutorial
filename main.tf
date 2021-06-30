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
resource "azurerm_virtual_network" "vnet" {
    name                = "myTFVnet"
    address_space       = ["10.10.10.0/24"]
    location            = "westeurope"
    resource_group_name = azurerm_resource_group.rg.name
}

