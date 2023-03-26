variable "vm_config" {
    type = list(object({
        name = string
        machine_type = string
        project = string
        zone = string
        boot_disk = set(object({
            auto_delete = bool
            device_name = string
            initialize_params = list(object(
                {
                    image = string
                    labels = map(string)
                    size = number
                    type = string
                }
            ))
        }))
        network_interface = set(object(
            {
                access_config = list(object({
                    nat_ip  = string
                    network_tier = string
                    public_ptr_domain_name = string
                }))
                name = string
                network = string
                network_ip = string
                nic_type = string
                subnetwork = string
                subnetwork_project = string
            }
        ))
    }))
}