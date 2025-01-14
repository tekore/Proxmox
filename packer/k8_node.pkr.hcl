packer {
  required_plugins {
    name = {
      version = "~> 1"
      source  = "github.com/hashicorp/proxmox"
    }
  }
}

variable "password" {
  type    = string
  default = "supersecret"
}

variable "username" {
  type    = string
  default = "apiuser@pve"
}

source "proxmox-iso" "ubuntu-kickstart" {
  node                     = "my-proxmox"
  password                 = "${var.password}"
  proxmox_url              = "https://my-proxmox.my-domain:8006/api2/json"
  ssh_password             = "Notanactualpassword"
  ssh_timeout              = "1m"
  ssh_username             = "Notanaztualuser"
  template_description     = "Ubuntu-Server-24.04, generated on ${timestamp()}"
  template_name            = "Ubuntu-24"
  username                 = "${var.username}"
  boot_command             = ["<up><tab> ip=dhcp inst.cmdline inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg<enter>"]
  boot_wait                = "10s"
  http_directory           = "config"
  insecure_skip_tls_verify = true
  disks {
    disk_size         = "5G"
    storage_pool      = "local-lvm"
    type              = "scsi"
  }
  efi_config {
    efi_storage_pool  = "local-lvm"
    efi_type          = "4m"
    pre_enrolled_keys = true
  }
  boot_iso {
    type = "scsi"
    iso_file = "https://releases.ubuntu.com/14.04.6/ubuntu-14.04.6-server-amd64.iso"
    unmount = true
    iso_checksum = "md5:401e9a5528bdae53b85f63996ae83773"
    iso_storage_pool = "local"
  }
  network_adapters {
    bridge = "vmbr0"
    model  = "virtio"
  }
  depends_on = [null.download-iso]
}
build {
  sources = ["source.proxmox-iso.ubuntu-kickstart"]
}
