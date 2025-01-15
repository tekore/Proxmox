packer {
  required_plugins {
    name = {
      version = "~> 1"
      source  = "github.com/hashicorp/proxmox"
    }
  }
}

variable "ssh_username" {
  type    = string
}

variable "ssh_password" {
  type    = string
}

variable "proxmox_url" {
  type    = string
}

source "proxmox-iso" "ubuntu-kickstart" {
  node                     = "my-proxmox"
  password                 = ""
  proxmox_url              = "${var.proxmox_url}"
  ssh_password             = "${var.ssh_password}"
  ssh_timeout              = "1m"
  ssh_username             = "${var.ssh_username}"
  template_description     = "Ubuntu-Server-24.04, generated on ${timestamp()}"
  template_name            = "Ubuntu-Server24.04"
  username                 = "${var.ssh_username}"
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
}
build {
  sources = ["source.proxmox-iso.ubuntu-kickstart"]
}
