.PHONY: install ssh

install:
	bin/install.sh

build:
	docker build -t cmcarthur/jetstream .

ssh:
	@ssh -A "ubuntu@$$(bin/terraform output -state=state/terraform.tfstate bastion_ip)"
