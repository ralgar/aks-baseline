# Baseline AKS Cluster

## Overview

This project follows the GitOps paradigm to provision an AKS Cluster.

**Note:** This is still a WIP

### Features

- [x] Self-updating, using Azure functionality and [Kured](https://kured.dev).
- [x] Prometheus + Grafana for observability.
- [ ] Integrated with Azure Key Vault via Azure AD Workload Identity.

## Usage

### Prerequisites

- azure-cli
- kubectl

### Initial Setup

1. Clone this repository and change directory into it.

   ```sh
   git clone https://repo-path
   cd repo-path
   ```

1. Initialize Terraform.

   ```sh
   terraform init
   ```

1. Login to the Azure CLI.

   ```sh
   az login
   ```

### Creating the cluster

1. (Optional) Review the Terraform plan.

   ```sh
   terraform plan
   ```

1. Apply the infrastructure changes.

   ```sh
   terraform apply
   ```

### Destroying the cluster

1. Destroy the infrastructure.

   ```sh
   terraform destroy
   ```
