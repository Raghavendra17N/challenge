resource "google_compute_router_nat" "nat" {
  name = var.name
  nat_ips = var.nat_ips
  project = var.project
  region = var.region
  router = var.router_name
  source_subnetwork_ip_ranges_to_nat = var.source_subnetwork_ip_ranges_to_nat
  nat_ip_allocate_option = "AUTO_ONLY"
  
  dynamic "subnetwork" {
    for_each = var.subnetwork
    content {
      name = subnetwork.value["name"]
      secondary_ip_range_names = subnetwork.value["secondary_ip_range_names"]
      source_ip_ranges_to_nat = subnetwork.value["source_ip_ranges_to_nat"]
    }
  }

}