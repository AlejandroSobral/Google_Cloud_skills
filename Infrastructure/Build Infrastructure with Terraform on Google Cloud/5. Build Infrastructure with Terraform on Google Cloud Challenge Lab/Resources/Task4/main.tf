terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.55.0"
    }
  }
}

provider "google" {
  project     = var.project_id
  region      = var.region

  zone        = var.zone
}

module "instances" {
  source     = "./modules/instances"
}

##### ADDED
module "storage" {
  source     = "./modules/storage"
}

terraform {
  backend "gcs" {
    bucket  = var.project_id
 prefix  = "terraform/state"
  }
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.55.0"
    }
  }
}