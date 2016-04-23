.PHONY: plan apply

CURRENT_DIR := ${PWD}

plan:
	docker run --rm -v "$(CURRENT_DIR)":/data \
		-v ~/.aws:/root/.aws \
		-v ~/.ssh:/root/.ssh \
		cmcarthur/jetstream \
		plan -input=false \
			 -state=/data/state/terraform.tfstate \
			 -var-file=/data/state/variables.tfvars \
			 -refresh=true \
			 /data/terraform/

apply:
	docker run --rm -v "$(CURRENT_DIR)":/data cmcarthur/jetstream \
		-v ~/.aws:/root/.aws \
		-v ~/.ssh:/root/.ssh \
		apply -input=false \
			  -state=/data/state/terraform.tfstate \
			  -var-file=/data/state/variables.tfvars \
			  -refresh=true \
			  /data/terraform/

ssh:
	@ssh -A "ubuntu@$$(bin/terraform output -state=state/terraform.tfstate bastion_ip)"
