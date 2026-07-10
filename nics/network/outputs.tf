output "network_name" {
  value       = google_compute_network.network.name
  description = "The name of the created VPC network."
}

output "network_self_link" {
  value       = google_compute_network.network.self_link
  description = "The URI of the created VPC network."
}