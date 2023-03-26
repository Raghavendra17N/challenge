variable subnet_config {
    type        = list(object({
    name = string
    network = string
    project = string
    ip_cidr_range = string
    region = string
    secondary_ranges = map(string)
  }))
  default = []
}