# Création du VPC
resource "google_compute_network" "main_vpc" {
  name                    = "devops-vpc"
  auto_create_subnetworks = false
}

# Création du sous-réseau
resource "google_compute_subnetwork" "private_subnet" {
  name          = "gke-subnet"
  ip_cidr_range = "10.0.0.0/20"
  region        = "europe-west1"
  network       = google_compute_network.main_vpc.id
}

# Cloud Router (nécessaire pour le NAT)
resource "google_compute_router" "router" {
  name    = "router"
  region  = google_compute_subnetwork.private_subnet.region
  network = google_compute_network.main_vpc.id
}

# NAT Gateway (permet aux nœuds Kubernetes d'aller sur internet)
resource "google_compute_router_nat" "nat" {
  name                               = "nat"
  router                             = google_compute_router.router.name
  region                             = google_compute_router.router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}