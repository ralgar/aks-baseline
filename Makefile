TF_DIR   := ./infra
HCL_VARS := ./vars/secret.hcl


# Print Makefile help dialog
help:
	$(info #########################)
	$(info ###   Makefile Help   ###)
	$(info #########################)
	$(info )
	$(info Usage: make [TARGET])
	$(info Carry out the functions of the chosen TARGET.)
	$(info )
	$(info Possible TARGETs for this project:)
	$(info   apply      Apply the infrastructure using Terraform)
	$(info   destroy    Destroy the infrastructure using Terraform)
	$(info )
	$(info )

# Build the infrastructure
apply:
	cd $(TF_DIR) && terraform apply --auto-approve

destroy:
	cd $(TF_DIR) && terraform destroy --auto-approve

clean:
	rm -rf output
