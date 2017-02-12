variable "network" {
  description = "the network name"
}

variable "subnetwork" {
  description = "the subnetwork name"
}

variable "zones" {
  description = "the zones to deploy into"
  type = "list"
}

variable "initial_node_count" {
  description = "the number of nodes to launch"
}

variable "cluster_admin_user" {
  description = "the username to log into the cluster"
}

variable "cluster_admin_password" {
  description = "the password to log into the cluster"
}