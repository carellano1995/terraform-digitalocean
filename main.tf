
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


data "template_file" "cloud-init-yaml" {
  template = file("cloud-init.yaml")
  vars = {
    init_ssh_public_key = var.ssh_key
    user                = "dev"
  }
}


resource "digitalocean_droplet" "web" {
  image     = var.image
  name      = var.name
  region    = var.region
  size      = var.size
  user_data = data.template_file.cloud-init-yaml.rendered
  ssh_keys = ["${digitalocean_ssh_key.carellanoSSH.fingerprint}"
  ]

}

resource "digitalocean_project" "terraform-test" {
  name        = "terraform-test"
  description = "A project to use terraform."
  purpose     = "Web Application"
  environment = "Development"
  resources   = [digitalocean_droplet.web.urn]
}

resource "digitalocean_ssh_key" "carellanoSSH" {
  name       = "carellanoSSH"
  public_key = var.ssh_key
}


