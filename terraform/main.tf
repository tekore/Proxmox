terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
      version = "0.69.1"
    }
  }
}

provider "proxmox" {
  ssh {
    agent = false
    username = var.proxmox_username
    private_key = var.proxmox_private_key
  }
}