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
