variable "cloudflare_api_token" {
  description = "A Cloudflare API token with sufficient permissions."
  type        = string
  sensitive   = true
}

variable "cloudflare_zone_name" {
  description = "The name of your Cloudflare zone (root domain)."
  type        = string
}

variable "environment" {
  description = "Deployment environment (prod, staging, demo)."
  default     = "demo"
  type        = string
}

variable "location" {
  description = "Location (region) for resources."
  default     = "West US 3"
  type        = string
}

variable "prefix" {
  description = "Prefix for naming resources."
  default     = "techdemo"
  type        = string
}
