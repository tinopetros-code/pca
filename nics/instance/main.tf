resource "google_compute_instance" "vm" {
    name = var.instance_name
    zone = var.instance_zone
    machine_type = var.instance_type
    boot_disk {
        initialize_params {
            image = "debian-cloud/debian-12"
        }  
    }
    network_interface {
        network = var.instance_network
        subnetwork = var.instance_subnetwork != null ? var.instance_subnetwork : null
        # we do this for optional values to make sure we pass null as a value and not a null reference?
        access_config {
        }
    }
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