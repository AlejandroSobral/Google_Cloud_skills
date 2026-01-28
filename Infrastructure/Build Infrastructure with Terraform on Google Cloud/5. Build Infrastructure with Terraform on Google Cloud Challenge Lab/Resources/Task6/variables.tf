variable "bucket_name" {
  description = "The name of the bucket to be created"
  default     = var.project_id
}

variable "project_id" {
    description = "The project ID to host the bucket in"
    default     = "TO-BE-CONFIGURED-TASK3"
  
}
variable "region" {
  description = "The assigned region"
  default     = "TO-BE-CONFIGURED-TASK1"
}

variable "zone" {
  description = "The assigned zone"
  default     = "TO-BE-CONFIGURED-TASK1"
}

variable "provider_version" {
    description = "The version of the Google provider"
    default     = "3.5.0"
}