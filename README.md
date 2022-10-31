Prereqs:
- azure-cli
- helm
- kubectl

Steps:
1. `az login`
1. `git clone repo`
1. `cd repo`
1. Create an Active Directory service principal account:

   ```sh
   $ az ad sp create-for-rbac
   {
     "appId": "aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa",
     "displayName": "azure-cli-2019-04-11-00-46-05",
     "name": "http://azure-cli-2019-04-11-00-46-05",
     "password": "aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa",
     "tenant": "aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa"
   }
   ```

1. Update your `terraform.tfvars` file.

   ```sh
   # terraform.tfvars
   aksAppID    = "aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa"
   aksPassword = "aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa"
   ```

1. `terraform init`
1. `terraform plan`
1. `terraform apply`

Destroying:

1. `terraform destroy`
