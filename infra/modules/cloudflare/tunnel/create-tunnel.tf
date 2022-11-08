data "cloudflare_zone" "zone" {
  name = var.cloudflare_zone
}

resource "random_password" "tunnel_secret" {
  length  = 32
  special = false
}

resource "cloudflare_argo_tunnel" "tunnel" {
  account_id = data.cloudflare_zone.zone.account_id
  name       = var.tunnel_name
  secret     = base64encode(random_password.tunnel_secret.result)
}

resource "cloudflare_record" "root" {
  zone_id = data.cloudflare_zone.zone.id
  name    = data.cloudflare_zone.zone.name
  value   = cloudflare_argo_tunnel.tunnel.cname
  type    = "CNAME"
  proxied = true
}

resource "cloudflare_record" "wildcard" {
  zone_id = data.cloudflare_zone.zone.id
  name    = "*"
  value   = data.cloudflare_zone.zone.name
  type    = "CNAME"
  proxied = true
}
