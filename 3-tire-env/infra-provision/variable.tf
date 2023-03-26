variable "network_config" {
  type        = any
  description = "Defining Network configuration"
}

variable "subnet_config" {
  type = list(object({
    name             = string
    network          = string
    project          = string
    ip_cidr_range    = string
    region           = string
    secondary_ranges = map(string)
  }))
  description = "Defining Subnet configuration"
}

variable "vm_config" {
  type        = any
  description = "Defining VM configuration"
}

variable "rules" {
  type        = any
  description = "Defining Firewall configuration"
}

variable "nat_config" {
  type        = any
  description = "Defining NAT configuration"
}

variable "router_config" {
  type        = any
  description = "Defining Network configuration"
}


