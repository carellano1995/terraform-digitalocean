output "ip_address" {
  value       = digitalocean_droplet.web.ipv4_address
  description = "Ip droplet: terraform-digitalocean"
}

output "price_hourly" {
  value       = digitalocean_droplet.web.price_hourly
  description = "price hourly"
}