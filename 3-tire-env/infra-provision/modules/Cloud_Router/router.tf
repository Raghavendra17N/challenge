resource "google_compute_router" "router" {

project = var.project
name = var.router_name 
region = var.region
network = var.router_network 
bgp{ 
asn=var.router_asn
}
}
resource "google_compute_route" "default" {

name = google_compute_router.router.name 
dest_range = var.dest_range
network = var.router_network
next_hop_gateway = var.next_hop_gateway
project = var.project
}