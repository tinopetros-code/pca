output "subnetwork_self_link" {
  value       = google_compute_subnetwork.subnet.self_link
  description = "The URI of the created VPC network."
}