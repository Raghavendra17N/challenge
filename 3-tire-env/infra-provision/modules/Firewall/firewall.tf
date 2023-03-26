locals {
    rules = {
        for i in var.rules : i.name => i 
    }
}

resource "google_compute_firewall" "firewall" {
  for_each = local.rules
  name = each.value.name
  direction = each.value.direction
  network = each.value.network
  project = each.value.project
  source_ranges= each.value.direction == "INGRESS" ? each.value.ranges : null
  destination_ranges = each.value.direction == "EGRESS" ? each.value.ranges : null
  source_tags = each.value.source_tags
  source_service_accounts = each.value.source_service_accounts
  target_tags = each.value.target_tags
  target_service_accounts = each.value.target_service_accounts
  priority = each.value.priority
  log_config {
    metadata = each.value.metadata
  }
  dynamic "allow" {
    for_each = each.value.allow
    content {
      ports = allow.value["ports"]
      protocol = allow.value["protocol"]
    }
  }

  dynamic "deny" {
    for_each = each.value.deny
    content {
      ports = deny.value["ports"]
      protocol = deny.value["protocol"]
    }
  }

}