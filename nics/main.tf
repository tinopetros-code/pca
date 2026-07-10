
# create networks with firewalls

module "default" {
    source = "./network"
    network_name = "default"
    auto_mode = true
}

module "mynetwork" {
    source = "./network"
    network_name = "mynetwork"
    auto_mode = true
}

module "managementnet" {
    source = "./network"
    network_name = "managementnet"
}

module "privatenet" {
    source = "./network"
    network_name = "privatenet"
}

# create subnets

module "managementsubnet-us" {
    source = "./subnetwork"
    subnet_name = "managementsubnet-us"
    subnet_region = "us-central1"
    subnet_cidr = "10.130.0.0/20"
    subnet_network = module.managementnet.network_self_link
}

module "privatesubnet-us" {
    source = "./subnetwork"
    subnet_name = "privatesubnet-us"
    subnet_region = "us-central1"
    subnet_cidr = "176.16.0.0/24"
    subnet_network = module.privatenet.network_self_link
}

# create vm instances

module "mynet-us-vm" {
  source           = "./instance"
  instance_name    = "mynet-us-vm"
  instance_zone    = "us-central1-a"
  instance_network = module.mynetwork.network_self_link
}

module "mynet-notus-vm" {
  source           = "./instance"
  instance_name    = "mynet-notus-vm"
  instance_zone    = "europe-west1-b"
  instance_network = module.mynetwork.network_self_link
}

module "private-us-vm" {
  source           = "./instance"
  instance_name    = "private-us-vm"
  instance_zone    = "us-central1-a"
  instance_network = module.privatenet.network_self_link
  instance_subnetwork = module.privatesubnet-us.subnetwork_self_link
}

module "managementnet-us-vm" {
  source           = "./instance"
  instance_name    = "managementnet-us-vm"
  instance_zone    = "us-central1-a"
  instance_network = module.managementnet.network_self_link
  instance_subnetwork = module.managementsubnet-us.subnetwork_self_link
}

module "fake-appliance-vm" {
  source           = "./instance"
  instance_name    = "fake-appliance-vm"
  instance_zone    = "us-central1-a"
  instance_network = module.default.network_self_link
}

resource "google_compute_instance" "appliance-vm" {
    name = "appliance-vm"
    zone = "us-central1-a"
    machine_type = "e2-micro"
    boot_disk {
        initialize_params {
            image = "debian-cloud/debian-12"
        }  
    }
    # network interfaces ie. nics
    network_interface {
        subnetwork = module.managementsubnet-us.subnetwork_self_link
    }
    network_interface {
        subnetwork = module.privatesubnet-us.subnetwork_self_link
    }
    #network_interface {
    #   subnetwork = "https://googleapis.com{var.project_id}/regions/us-central1/subnetworks/mynetwork"
    #}
    shielded_instance_config {
        enable_secure_boot          = true
        enable_vtpm                 = true
        enable_integrity_monitoring = true
    }
    scheduling {
        max_run_duration {
            seconds = 3600
            # run for no more than an hour
        }
        instance_termination_action = "DELETE"
        # "TERMINATE" would only turn it off to stop billing, but using the more blunt solution for now
    }
}