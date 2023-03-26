network_config = [{
  routing_mode                    = "GLOBAL"
  description                     = "Network VPC"
  auto_create_subnetworks         = false
  delete_default_routes_on_create = false
  name                            = "global-vpc"
  project                         = "charged-muse-376504"
  },
]


subnet_config = [{
  name          = "subnet-app"
  network       = "global-vpc"
  ip_cidr_range = "10.0.0.0/24"
  project       = "charged-muse-376504"
  region        = "us-central1"
  secondary_ranges = {
    pods     = "172.16.0.0/20"
    services = "192.168.0.0/24"
  } }, {
  name          = "subnet-db"
  network       = "global-vpc"
  ip_cidr_range = "10.0.10.0/24"
  project       = "charged-muse-376504"
  region        = "us-central1"
  secondary_ranges = {}
  },
]

vm_config = [{
  name         = "vm-app"
  machine_type = "f1-micro"
  project      = "charged-muse-376504"
  zone         = "us-central1-a"
  boot_disk = [{
    auto_delete = true
    device_name = "boot"
    initialize_params = [{
      image  = "projects/ubuntu-os-cloud/global/images/family/ubuntu-1804-lts"
      labels = {}
      size   = "10"
      type   = "pd-balanced"
    }]
  }]
  network_interface = [{
    access_config = [{
      nat_ip                 = null
      network_tier           = "STANDARD"
      public_ptr_domain_name = null
    }]
    name               = null
    network            = "global-vpc"
    network_ip         = null
    nic_type           = null
    subnetwork         = "subnet-app"
    subnetwork_project = "charged-muse-376504"
  }]
  },
  {
    name         = "vm-db"
    machine_type = "f1-micro"
    project      = "charged-muse-376504"
    zone         = "us-central1-a"
    boot_disk = [{
      auto_delete = true
      device_name = "boot"
      initialize_params = [{
        image  = "projects/ubuntu-os-cloud/global/images/family/ubuntu-1804-lts"
        labels = {}
        size   = "10"
        type   = "pd-balanced"
      }]
    }]
    network_interface = [{
      access_config = [{
        nat_ip                 = null
        network_tier           = "STANDARD"
        public_ptr_domain_name = null
      }]
      name               = null
      network            = "global-vpc"
      network_ip         = null
      nic_type           = null
      subnetwork         = "subnet-app"
      subnetwork_project = "charged-muse-376504"
    }]
}, ]


rules = [{
  project                 = "charged-muse-376504"
  network         = "global-vpc"
  name                    = "allow-ingress"
  description             = null
  direction               = "INGRESS"
  priority                = null
  ranges                  = ["0.0.0.0/0"]
  metadata                = "INCLUDE_ALL_METADATA"
  source_tags             = null
  source_service_accounts = null
  target_tags             = null
  target_service_accounts = null
  allow = [{
    protocol = "tcp"
    ports    = ["8000", "3000", "27017"]
  }]
  deny = []
 }, 
 ]


nat_config = [{
  project                            = "charged-muse-376504"
  region                             = "us-central1"
  name                               = "cloud-nat-1"
  router_name                        = "router-01"
  nat_subnet_name = "projects/charged-muse-376504/regions/us-central1/subnetworks/subnet-db"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  source_ip_ranges_to_nat            = ["PRIMARY_IP_RANGE"]
}, ]


router_config = [{
  project          = "charged-muse-376504"
  region           = "us-central1"
  name             = "cloud-nat-11"
  router_name      = "router-01"
  router_network   = "global-vpc"
  router_asn       = 64514
  dest_range       = "0.0.0.0/0"
  next_hop_gateway = "default-internet-gateway"
  priority         = 100
}, ]