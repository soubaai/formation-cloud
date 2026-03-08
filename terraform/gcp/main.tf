terraform {
  required_version = ">= 1.5.0"
  # Backend local pour commencer, mais tu peux ajouter le bloc "gcs" ici plus tard
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project = "isentropic-disk-301915"
  region  = "europe-west1"
}