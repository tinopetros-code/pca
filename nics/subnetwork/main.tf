# create subnetwork
resource "google_compute_subnetwork" "subnet" {
    name          = "${var.subnet_name}"
    region        = "${var.subnet_region}"
    ip_cidr_range = "${var.subnet_cidr}"
    network       = "${var.subnet_network}"
}