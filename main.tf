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
  type        = string
  description = "The Google Cloud Platform Credentials to be used to manage resources."
}

// Configure the Google Cloud provider
provider "google" {
  credentials = var.google_credentials
  project     = "world-wide-coffee"
  region      = "europe-west1"
}
