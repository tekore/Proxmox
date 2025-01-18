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
    insecure = true
    agent = true
  }
}