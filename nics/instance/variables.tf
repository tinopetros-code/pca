variable "instance_name" {}
variable "instance_zone" {}
variable "instance_type" {
    default = "e2-micro"
}
variable "instance_network" {}
variable "instance_subnetwork" {
    default = null # optional, only required when deploying to custom mode networks
}