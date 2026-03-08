resource "google_container_cluster" "primary" {
  name     = "devops-cluster"
  location = "europe-west1-b"

  network    = google_compute_network.main_vpc.name
  subnetwork = google_compute_subnetwork.private_subnet.name

  # On optimise les coûts en séparant la gestion des nœuds
  remove_default_node_pool = true
  initial_node_count       = 1
}

resource "google_container_node_pool" "primary_nodes" {
  name       = "node-pool"
  location   = "europe-west1-b"
  cluster    = google_container_cluster.primary.name
  node_count = 1 # Commence avec 1 pour le budget, passe à 2 si ArgoCD rame

  node_config {
    preemptible  = true
    machine_type = "e2-standard-2" # Obligatoire pour supporter ArgoCD + Runner

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}