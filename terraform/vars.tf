variable "proxmox_username" {
   description = "Proxmox API Username"
   type        = string
   sensitive   = true
}

variable "proxmox_private_key" {
   description = "Proxmox API Key"
   type        = string
   sensitive   = true
}
