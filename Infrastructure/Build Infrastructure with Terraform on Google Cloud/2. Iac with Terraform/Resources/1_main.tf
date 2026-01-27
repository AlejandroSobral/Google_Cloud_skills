
##This resource includes a few more arguments. The name and machine type are simple strings, but boot_disk and network_interface are more complex blocks. You can see all of the available options in the google_compute_instance documentation.
##For this example, your compute instance will use a Debian operating system, and will be connected to the VPC Network you created earlier. Notice how this configuration refers to the network's name property with google_compute_network.vpc_network.name -- google_compute_network.vpc_network is the ID, matching the values in the block that defines the network, and name is a property of that resource.
##The presence of the access_config block, even without any arguments, ensures that the instance is accessible over the internet.


terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {

  project = "qwiklabs-gcp-03-4b8b526e5de1"
  region  = "us-west1"
  zone    = "us-west1-c"
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}

resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "e2-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
    }
  }
}