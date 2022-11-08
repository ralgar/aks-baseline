module "aks_cluster" {
  source = "./modules/azure/aks-cluster"

  environment = var.environment
  location    = var.location
  prefix      = var.prefix
}

module "flux_cd" {
  source = "./modules/kubernetes/flux-cd"
}

module "cloudflare_tunnel" {
  source = "./modules/cloudflare/tunnel"

  cloudflare_zone = var.cloudflare_zone_name
  tunnel_name     = "root_tunnel"
}

module "cloudflared_config" {
  source = "./modules/kubernetes/cloudflared"

  account_id    = module.cloudflare_tunnel.account_id
  tunnel_id     = module.cloudflare_tunnel.tunnel_id
  tunnel_name   = module.cloudflare_tunnel.tunnel_name
  tunnel_secret = module.cloudflare_tunnel.tunnel_secret
  zone_name     = module.cloudflare_tunnel.zone_name
}
