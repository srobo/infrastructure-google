provider "google" {
  credentials = "${file("secrets/credentials.json")}"
  project = "${var.google_project_name}"
  region = "${var.google_region}"
}

module "network" {
  source = "modules/network"
  name = "srobo"
  subnet_cidrs = {
    europe-west1 = "10.132.0.0/20"
  }
}

module "website" {
  source = "modules/website"
  network = "${module.network.network}"
  subnetwork = "${module.network.subnetworks["europe-west1"]}"
  cluster_admin_user = "${var.cluster_admin_user}"
  cluster_admin_password = "${var.cluster_admin_password}"
  initial_node_count = 1
  zones = [
    "europe-west1-b",
    "europe-west1-c"
  ]
}
