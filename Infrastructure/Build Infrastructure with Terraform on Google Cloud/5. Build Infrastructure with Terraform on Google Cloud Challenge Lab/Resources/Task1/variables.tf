variable "project_id" {
  description = "The project ID to host the network in"
  default     = "qwiklabs-gcp-01-131cb5c3a84b"
}

variable "region" {
  description = "The assigned region"
  default     = "europe-west1"
}

variable "zone" {
  description = "The assigned zone"
  default     = "europe-west1-c"
}

variable "provider_version" {
    description = "The version of the Google provider"
    default     = "3.5.0"
}

