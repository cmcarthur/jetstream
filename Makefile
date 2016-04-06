.PHONY: install_mac plan apply

install_mac:
	wget "https://releases.hashicorp.com/terraform/0.6.14/terraform_0.6.14_darwin_amd64.zip" -P /tmp
	unzip /tmp/terraform_0.6.14_darwin_amd64.zip -d bin/
	rm /tmp/terraform_0.6.14_darwin_amd64.zip

plan:
	bin/terraform plan \
		-state=state/terraform.tfstate \
		-refresh=true \
		terraform/

apply:
	bin/terraform apply \
		-state=state/terraform.tfstate \
		-refresh=true \
		terraform/
