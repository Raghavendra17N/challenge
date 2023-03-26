locals {
  subnet_config = {
    for i in var.subnet_config : i.name => i
  }
}


resource "google_compute_subnetwork" "subent" {
  for_each = local.subnet_config
  description = "Subet for 3-tire env"
  ip_cidr_range = each.value.ip_cidr_range
  name = each.value.name
  network = each.value.network
  project = each.value.project
  region = each.value.region
  secondary_ip_range = each.value.secondary_ranges == null ? [] : [
    for name, range in each.value.secondary_ranges :
    { range_name = name , ip_cidr_range = range}
  ]


}