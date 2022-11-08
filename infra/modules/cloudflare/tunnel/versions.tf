terraform {
  required_version = ">=1.0"

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "3.27.0"
    }
    random = {
      source = "hashicorp/random"
      version = "3.4.3"
    }
  }
}
