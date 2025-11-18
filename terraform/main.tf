# ------ VPC ------
resource "google_compute_network" "vpc" {
    name                    = "demo-gke-vpc"
    auto_create_subnetworks = false
}

# ------ Subnet ------
resource "google_compute_subnetwork" "subnet" {
    name          = "demo-gke-subnet"
    ip_cidr_range = "10.10.0.0/16"
    region        = var.region
    network       = google_compute_network.vpc.id
}

# ------ GKE Cluster ------
resource "google_container_cluster" "primary" {
    name     = var.cluster_name
    location = var.region

    network    = google_compute_network.vpc.id
    subnetwork = google_compute_subnetwork.subnet.id

    remove_default_node_pool = true
    initial_node_count       = 1

    release_channel {
        channel = "REGULAR"
    }

    ip_allocation_policy{}
}

# ------ Node Pool ------
resource "google_container_node_pool" "primary_nodes" {
  name       = "${var.cluster_name}-np"
  location   = var.region
  cluster    = google_container_cluster.primary.name

  node_count = 1

  node_config {
    machine_type = "e2-medium"
    disk_type    = "pd-balanced"
    disk_size_gb = 50
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }
}
