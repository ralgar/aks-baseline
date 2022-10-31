variable "aksAppID" {
  description = "AKS Cluster service principal"
  sensitive   = true
}

variable "aksPassword" {
  description = "AKS Cluster password"
  sensitive   = true
}

variable "aksClusterLocation" {
  description = "AKS Cluster location"
  default     = "West US 2"
}
