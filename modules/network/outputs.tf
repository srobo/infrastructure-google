output "network" {
  value = "${google_compute_network.network.name}"
}

output "subnetworks" {
  value = {
    europe-west1 = "${google_compute_subnetwork.subnet-europe-west1.name}"
  }
}