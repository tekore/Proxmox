terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
      version = "0.69.1"
    }
  }
}

provider "proxmox" {
  insecure = true
  ssh {
    node {
      name    = "onprem"
      address = var.PROXMOX_ADDRESS
      port = var.PROXMOX_SSH_PORT
    }
    agent = true
  }
}
