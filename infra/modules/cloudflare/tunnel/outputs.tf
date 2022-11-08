output "account_id" {
  value = data.cloudflare_zone.zone.account_id
}

output "tunnel_id" {
  value = cloudflare_argo_tunnel.tunnel.id
}

output "tunnel_name" {
  value = cloudflare_argo_tunnel.tunnel.name
}

output "tunnel_secret" {
  value     = cloudflare_argo_tunnel.tunnel.secret
  sensitive = true
}

output "zone_name" {
  value = data.cloudflare_zone.zone.name
}
