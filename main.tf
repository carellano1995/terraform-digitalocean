
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
  ssh_keys = ["${digitalocean_ssh_key.terra.fingerprint}"
  ]

}

resource "digitalocean_project" "terraform-test" {
  name        = "terraform-test"
  description = "A project to use terraform."
  purpose     = "Web Application"
  environment = "Development"
  resources   = [digitalocean_droplet.web.urn]
}

resource "digitalocean_ssh_key" "terra" {
  name       = "terra"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDA0OI37fIwElQMqZeoymVV+FkG3DbtP3Ch2FuC00DXEr3PYg0dY0McbehukOKRdivcCiIjDKa3iBio0hlE9IXqaes1KaTNsLIncBwfEkgfxh49X1jiVIPDXQWV4zVIeVwAsgS922L7K83OWFHcYMRZnnJ/zqC183+GPvjCmy8zavf0K6yngIn13/5gFtJXhdqORr8jeZXx6cINSY31c6bjFtkBY7gAtTIAkEgJLEzP6Nvi3D45FmeIDvXT5RY1IsIGi9FfEAJE7EzVxhMxYsjhAKsIAetvlh9vQEF6N4tX3bVNgnueEBggiFOP5QII+raGTCl7+H3qHz/dirDOkld1 carellano@Admins-MacBook-Pro.local"
}

