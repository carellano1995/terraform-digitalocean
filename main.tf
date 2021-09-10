
terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
    }
  }
}

output "TOKEN" {
  value       = var.do_token
  description = "region"
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

