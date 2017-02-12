resource "google_compute_network" "network" {
  name = "${var.name}-network"
}

resource "google_compute_subnetwork" "subnet-europe-west1" {
  name          = "${var.name}-europe-west1"
  ip_cidr_range = "${var.subnet_cidrs["europe-west1"]}"
  network       = "${google_compute_network.network.name}"
  region        = "europe-west1"
}

resource "google_compute_firewall" "allow-internal" {
  description   = "Allows the network to communicate within itself"
  name          = "allow-internal"
  network       = "${google_compute_network.network.name}"
  source_ranges = ["${google_compute_subnetwork.subnet-europe-west1.ip_cidr_range}"]

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }
}

resource "google_compute_firewall" "allow-external-ssh" {
  description = "Allows anyone to SSH into the network"
  name        = "allow-external-ssh"
  network     = "${google_compute_network.network.name}"
  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}

resource "google_compute_firewall" "allow-external-icmp" {
  description = "Allows anyone to icmp into the network"
  name        = "allow-external-icmp"
  network     = "${google_compute_network.network.name}"
  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "icmp"
  }
}

resource "google_compute_firewall" "allow-external-rdp" {
  description = "Allows anyone to RDP into the network"
  name        = "allow-external-rdp"
  network     = "${google_compute_network.network.name}"
  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }
}
