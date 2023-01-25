# Baseline AKS Cluster

## Overview

This project follows the GitOps paradigm to provision an AKS Cluster.

**Note:** This is still a WIP

### Features

- [x] Self-updating, using Azure functionality and [Kured](https://kured.dev).
- [x] Prometheus + Grafana for observability.
- [x] Integrated with Azure Key Vault via Azure AD Workload Identity.

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

## CI configuration

If you intend to use the CI workflow to provision the infrastructure, you will
 need to do some additional configuration.

### Configure Terraform Cloud

1. Create a new Organization, or use an existing one.

1. Create two API-driven Workspaces, one for your production environment and
   one for your staging environment.

1. In each Workspace's Settings, ensure the Execution Mode is set to *Local*,
   and the Remote State Sharing is set to share with the other Workspace.

1. Go to the [Tokens page](https://app.terraform.io/app/settings/tokens) in
   your Terraform Cloud User Settings, and create a new API token named
   *GitHub Actions*.

### Configure Azure Active Directory

1. Create an Azure AD Service Principal, with limited scope, for Terraform.

   ```sh
   export MSYS_NO_PATHCONV=1
   az ad sp create-for-rbac \
       --name <service_principal_name> \
       --role Owner \
       --scopes /subscriptions/<subscription_id>
   ```

1. Grant the required permissions for the Microsoft Graph API.

   ```sh
   az ad app permission add \
       --id <service_principal_application_id> \
       --api 00000003-0000-0000-c000-000000000000 \
       --api-permissions 1bfefb4e-e0b5-418b-a88f-73c46d2cc8e9=Role

   az ad app permission grant \
       --id <service_principal_application_id> \
       --api 00000003-0000-0000-c000-000000000000 \
       --scope Application.ReadWrite.All
   ```

### Configure your GitHub repository

1. Using the values provided in the previous steps, create the following
   repository-scoped Secrets.

   ```sh
   ARM_SUBSCRIPTION_ID="<azure_subscription_id>"
   ARM_TENANT_ID="<azure_subscription_tenant_id>"
   ARM_CLIENT_ID="<service_principal_appid>"
   ARM_CLIENT_SECRET="<service_principal_password>"
   TF_API_TOKEN="<terraform_cloud_api_token>"
   TF_CLOUD_ORGANIZATION="<terraform_cloud_organization>"
   ```

1. Create two Environments, named `production` and `staging`. In each one, set
   an environment-scoped Secret named `TF_WORKSPACE`, with each value set to
   the name of the corresponding Workspace you created in the
   [Configure Terraform Cloud](#configure-terraform-cloud) step.
