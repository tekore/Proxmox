packer {
  required_plugins {
    name = {
      version = "~> 1"
      source  = "github.com/hashicorp/proxmox"
    }
  }
}

boot_iso {
  type = "scsi"
  iso_url = "https://releases.ubuntu.com/14.04.6/ubuntu-14.04.6-server-amd64.iso"
  unmount = true
  iso_checksum = "md5:401e9a5528bdae53b85f63996ae83773"
}