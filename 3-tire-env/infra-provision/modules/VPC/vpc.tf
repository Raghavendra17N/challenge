resource "google_compute_network" "vpc" {
  auto_create_subnetworks = false
  delete_default_routes_on_create = var.delete_default_routes_on_create
  description = var.description
  name = var.name
  project = var.project
  routing_mode = var.routing_mode

}