variable "os_version" {
  type = string
}
variable "image_version" {
  type = string
}

variable "subscription_id" {
  type = string
}

variable "client_id" {
  type = string
}
variable "client_secret" {
  type = string
}
source "azure-arm" "centos-6" {

  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  # source image details - using Marketplace image
  os_type         = "Linux"
  image_publisher = "OpenLogic"
  image_offer     = "CentOS"
  image_sku       = "6.9"

  # Final image details
  managed_image_resource_group_name = "packer-images-rg"
  managed_image_name                = "centos-6-{{timestamp}}"

  # Publish image to SIG
  shared_image_gallery_destination {
    resource_group       = "packer-images-rg"
    gallery_name         = "SharedImageGallery"
    image_name           = "centos-6"
    image_version        = var.image_version
    storage_account_type = "Standard_LRS"
    replication_regions  = ["australiaeast"]
  }

  # The build config - rg, vm size, network details 
  build_resource_group_name              = "packer-temp-rg"
  vm_size                                = "Standard_B1s"
  private_virtual_network_with_public_ip = true
  virtual_network_name                   = "packer-vnet"
  virtual_network_subnet_name            = "packer-subnet"
}


source "azure-arm" "centos-7" {

  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  # source image details - using Marketplace image
  os_type         = "Linux"
  image_publisher = "OpenLogic"
  image_offer     = "CentOS"
  image_sku       = "7_9"

  # Final image details
  managed_image_resource_group_name = "packer-images-rg"
  managed_image_name                = "centos-7-{{timestamp}}"

  # Publish image to SIG
  shared_image_gallery_destination {
    resource_group       = "packer-images-rg"
    gallery_name         = "SharedImageGallery"
    image_name           = "centos-7"
    image_version        = var.image_version
    storage_account_type = "Standard_LRS"
    replication_regions  = ["australiaeast"]
  }

  # The build config - rg, vm size, network details 
  build_resource_group_name              = "packer-temp-rg"
  vm_size                                = "Standard_B1s"
  private_virtual_network_with_public_ip = true
  virtual_network_name                   = "packer-vnet"
  virtual_network_subnet_name            = "packer-subnet"
}



build {
  name = "centos"

  sources = [
    "source.azure-arm.centos-7",
    "source.azure-arm.centos-6"
  ]
  provisioner "file" {
    source      = "../scripts/centos-6_generalise.sh"
    destination = "/tmp/generalise.sh"
    only        = ["azure-arm.centos-6"]
  }

  provisioner "file" {
    source      = "../scripts/centos-7_generalise.sh"
    destination = "/tmp/generalise.sh"
    only        = ["azure-arm.centos-7"]
  }

  provisioner "shell" {

    inline = [
      "sudo chmod +x /tmp/generalise.sh",
      "bash /tmp/generalise.sh"
    ]
  }
}

