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

1. Enable the [Workload Identity Preview](https://learn.microsoft.com/en-us/azure/aks/workload-identity-deploy-cluster#register-the-enableworkloadidentitypreview-feature-flag)
   feature.

   ```sh
   # Enable the feature flag
   az feature register --namespace "Microsoft.ContainerService" --name "EnableWorkloadIdentityPreview"

   # Wait until the status shows "Registered" (may take a few minutes)
   az feature show --namespace "Microsoft.ContainerService" --name "EnableWorkloadIdentityPreview"

   # Refresh the registration of the Microsoft.ContainerService provider
   az provider register --namespace Microsoft.ContainerService
   ```

### CI configuration

If you intend to use a CI workflow to provision the infrastructure, you will
 need to do some additional configuration.

1. Create an Organization, and an API-driven Workflow in Terraform Cloud.

1. Create an Azure AD Service Principal, with limited scope, for Terraform.

   ```sh
   export MSYS_NO_PATHCONV=1
   az ad sp create-for-rbac \
       --name <service_principal_name> \
       --role Contributor \
       --scopes /subscriptions/<subscription_id>
   ```

1. Using the values provided in the previous step, create the following
   *sensitive environment variables* in Terraform Cloud.

   ```sh
   ARM_SUBSCRIPTION_ID="<azure_subscription_id>"
   ARM_TENANT_ID="<azure_subscription_tenant_id>"
   ARM_CLIENT_ID="<service_principal_appid>"
   ARM_CLIENT_SECRET="<service_principal_password>"
   ```

1. Go to the [Tokens page](https://app.terraform.io/app/settings/tokens) in
   your Terraform Cloud User Settings, and create a new API token named
   *GitHub Actions*.

1. In your GitHub repository, create a new secret called `TF_API_TOKEN`

1. Use Pull Requests to *plan* and *apply* the infrastructure.

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
