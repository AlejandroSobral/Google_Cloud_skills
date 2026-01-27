
## The resource name must be unique within a project and zone.
## It indicates the type of resource.
## In this case, we are creating a Compute Engine instance.
resource "google_compute_instance" "default" {
  project      = "qwiklabs-gcp-02-219c213a63cf"
  zone         = "europe-west1-b"
  name         = "terraform"
  machine_type = "e2-medium"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }
  network_interface {
    network = "default"
  }
}