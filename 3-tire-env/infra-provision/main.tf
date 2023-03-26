module "VPC" {
  source                          = "./modules/VPC"
  for_each                        = { for i in var.network_config : i.name => i }
  name                         = each.value["name"]
  project                         = each.value["project"]
  routing_mode                    = each.value["routing_mode"]
  description                     = each.value["description"]
  delete_default_routes_on_create = each.value["delete_default_routes_on_create"]
}

module "Subnets" {
  source        = "./modules/Subnets"
  subnet_config = var.subnet_config
  depends_on    = [module.VPC]
}

module "VM" {
  source     = "./modules/VM"
  vm_config  = var.vm_config
  depends_on = [module.Subnets]
}

module "Firewall" {
  source     = "./modules/Firewall"
  rules  = var.rules
  depends_on = [module.VPC]
}

module "Nat" {
  source      = "./modules/cloud_NAT"
  for_each    = { for i in var.nat_config : i.project => i }
  project     = each.value["project"]
  region      = each.value["region"]
  name        = each.value["name"]
  router_name = each.value["router_name"]
  source_subnetwork_ip_ranges_to_nat = each.value["source_subnetwork_ip_ranges_to_nat"]
  subnetwork = [{
    name                    = each.value["nat_subnet_name"]
    secondary_ip_range_names      = null
    source_ip_ranges_to_nat = each.value["source_ip_ranges_to_nat"]
  }]
  depends_on = [module.Router]
}

module "Router" {
  source           = "./modules/Cloud_Router"
  for_each         = { for i in var.router_config : i.router_name => i }
  router_name      = each.value["router_name"]
  project          = each.value["project"]
  region           = each.value["region"]
  router_network   = each.value["router_network"]
  router_asn       = each.value["router_asn"]
  dest_range       = each.value["dest_range"]
  next_hop_gateway = each.value["next_hop_gateway"]
  depends_on       = [module.VPC]
}