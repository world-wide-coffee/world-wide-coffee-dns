terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }

  backend "remote" {
   organization = "world-wide-coffee"

    workspaces {
      name = "world-wide-coffee-dns"
    }
  }
}


variable "google_credentials" {
  type = string
  description = "The Google Cloud Platform Credentials to be used to manage resources."
}

// Configure the Google Cloud provider
provider "google" {
  credentials = var.google_credentials
  project     = "world-wide-coffee"
  region      = "europe-west1"
}

data "google_dns_managed_zone" "root" {
  name = "world-wide-coffee"
}

resource "google_dns_record_set" "developer" {
  name = "developer.${data.google_dns_managed_zone.root.dns_name}"
  type = "TXT"
  ttl  = 300

  managed_zone = data.google_dns_managed_zone.root.name

  rrdatas = ["test"]
}
