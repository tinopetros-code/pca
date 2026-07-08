# Create network
resource "google_compute_network" "mynetwork" {
    name = "mynetwork"
    auto_create_subnetworks = true
}

# Add a firewall rule to allow HTTP, SSH, RDP and ICMP traffic on mynetwork
resource "google_compute_firewall" "mynetwork-allow-http-ssh-rdp-icmp" {
    name = "mynetwork"
    network = google_compute_network.mynetwork.self_link
    allow {
        protocol = "tcp"
        ports    = ["22", "80", "3389"]
        }
    allow {
        protocol = "icmp"
        }
    source_ranges = ["0.0.0.0/0"]
}