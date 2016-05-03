.PHONY: plan apply install ssh

install:
	bin/install.sh

plan:
	bin/jet plan -input=false \
				 -state=/data/state/terraform.tfstate \
				 -var-file=/data/state/variables.tfvars \
				 -refresh=true \
				 /data/terraform/

apply:
	bin/jet apply -input=false \
				  -state=/data/state/terraform.tfstate \
				  -var-file=/data/state/variables.tfvars \
				  -refresh=true \
				  /data/terraform/

ssh:
	@ssh -A "ubuntu@$$(bin/terraform output -state=state/terraform.tfstate bastion_ip)"
