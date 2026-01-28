provider "google" {
  project     = "qwiklabs-gcp-02-b0fad18570d2"
  region      = "europe-west1"
}

resource "google_storage_bucket" "test-bucket-for-state" {
  name        = "qwiklabs-gcp-02-b0fad18570d2"
  location    = "US"
  uniform_bucket_level_access = true
}


terraform {
  backend "gcs" {
    bucket  = "qwiklabs-gcp-02-b0fad18570d2"
    prefix  = "terraform/state"
  }
}