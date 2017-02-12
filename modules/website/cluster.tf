resource "google_container_cluster" "srobo-cluster" {
  name = "srobo-website"
  zone = "${var.zones[0]}"
  network = "${var.network}"
  subnetwork = "${var.subnetwork}"
  additional_zones = ["${var.zones}"]
  initial_node_count = "${var.initial_node_count}"

  node_config {
    machine_type = "g1-small"
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring"
    ]
  }

  "master_auth" {
    username = "${var.cluster_admin_user}"
    password = "${var.cluster_admin_password}"
  }
}
