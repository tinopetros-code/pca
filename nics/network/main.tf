# Create network
resource "google_compute_network" "network" {
    name = "${var.network_name}"
    auto_create_subnetworks = "${var.auto_mode}"
}

# Add a firewall rule to allow HTTP, SSH, RDP and ICMP traffic on mynetwork
resource "google_compute_firewall" "allow-http-ssh-rdp-icmp" {
    name = "${var.network_name}-allow-http-ssh-rdp-icmp"
    network = google_compute_network.network.self_link
    allow {
        protocol = "tcp"
        ports    = ["22", "80", "3389"]
        }
    allow {
        protocol = "icmp"
        }
    source_ranges = ["0.0.0.0/0"]
}