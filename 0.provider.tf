terraform {
  required_version = ">=1.6"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.00.0"
    }
  }
}

provider "google" {
  credentials = file("/root/terraform-lab1-408906-758ff302bdb.json")
  project     = var.project
  region      = var.region
  #  location = var.location
  zone = var.zone
}

#resource "google_project" "project" {
#  name                = "terraform-lab1"
#  project_id          = var.project
#  auto_create_network = "false"
#}



resource "random_id" "unique_suffix" {
  byte_length = 4
}
