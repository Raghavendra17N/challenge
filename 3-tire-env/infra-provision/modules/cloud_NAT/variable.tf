variable "name" {
  description = "(required) - Name of the NAT service. The name must be 1-63 characters long and\ncomply with RFC1035."
  type        = string
}

variable "nat_ips" {
  type        = set(string)
  default     = []
}

variable "project" {
  type        = string
  default     = null
}

variable "region" {
  type        = string
  default     = null
}

variable "router_name" {
  type        = string
}

variable "source_subnetwork_ip_ranges_to_nat" {
  type        = string
}
variable "subnetwork" {
  type = set(object(
    {
      name                     = string
      secondary_ip_range_names = set(string)
      source_ip_ranges_to_nat  = set(string)
    }
  ))
  default = []
}