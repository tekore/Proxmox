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
    private_key = file("~/.ssh/id_rsa") # cat this into a file and use it here in the pipeline
  }
}