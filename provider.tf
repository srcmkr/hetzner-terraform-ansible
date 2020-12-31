# ---------------------------------------
# adding hetzner cloud terraform provider
# ---------------------------------------
terraform {
  required_providers {
    hcloud = {
      source = "hetznercloud/hcloud"
    }
  }
}

provider "hcloud" {
  token = file("secrets/apitoken")
}