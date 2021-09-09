variable "do_token" {}

terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

resource "digitalocean_droplet" "web" {
  image     = var.image
  name      = "terraform-droplet"
  region    = var.region
  size      = var.size
  user_data = file("cloud-init.yaml")
  ssh_keys = ["${digitalocean_ssh_key.default.fingerprint}"
  ]

}

resource "digitalocean_ssh_key" "default" {
  name       = "Carellano"
  public_key = "ssh-rsa ..."
}

