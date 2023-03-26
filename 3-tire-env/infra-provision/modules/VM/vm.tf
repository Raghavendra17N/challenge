locals {
    vm_config = {
        for i in var.vm_config : i.name => i
    }
}

resource "google_compute_instance" "vm" {
  for_each = local.vm_config
  machine_type = each.value.machine_type
  name = each.value.name
  project = each.value.project
  zone = each.value.zone

  dynamic "boot_disk" {
    for_each = each.value.boot_disk
    content {
      auto_delete = boot_disk.value["auto_delete"]
      device_name = boot_disk.value["device_name"]
    #   disk_encryption_key_raw = boot_disk.value["disk_encryption_key_raw"]
    #   kms_key_self_link = boot_disk.value["kms_key_self_link"]
    # mode = boot_disk.value["mode"]
    #   source = boot_disk.value["source"]

      dynamic "initialize_params" {
        for_each = boot_disk.value.initialize_params
        content {
          image = initialize_params.value["image"]
          labels = initialize_params.value["labels"]
          size = initialize_params.value["size"]
          type = initialize_params.value["type"]
        }
      }

    }
  }


  dynamic "network_interface" {
    for_each = each.value.network_interface
    content {
      network = network_interface.value["network"]
      network_ip = network_interface.value["network_ip"]
      nic_type = network_interface.value["nic_type"]
      subnetwork = network_interface.value["subnetwork"]
      subnetwork_project = network_interface.value["subnetwork_project"]

      dynamic "access_config" {
        for_each = network_interface.value.access_config
        content {
          nat_ip = access_config.value["nat_ip"]
          network_tier = access_config.value["network_tier"]
          public_ptr_domain_name = access_config.value["public_ptr_domain_name"]
        }
      }
    }
  }

}