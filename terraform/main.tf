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
    username = var.PROXMOX_VE_USERNAME
    private_key = var.PROXMOX_VE_SSH_PRIVATE_KEY
  }
}