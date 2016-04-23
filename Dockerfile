FROM ubuntu:14.04

RUN apt-get update && \
	apt-get --assume-yes install unzip wget

RUN wget 'https://releases.hashicorp.com/terraform/0.6.14/terraform_0.6.14_linux_amd64.zip' -P /tmp && \
	unzip /tmp/terraform_0.6.14_linux_amd64.zip -d /bin/ && \
	rm /tmp/terraform_0.6.14_linux_amd64.zip

RUN rm /bin/terraform-provider-atlas \
	   /bin/terraform-provider-azure \
	   /bin/terraform-provider-azurerm \
	   /bin/terraform-provider-chef \
	   /bin/terraform-provider-clc \
	   /bin/terraform-provider-cloudflare \
	   /bin/terraform-provider-cloudstack \
	   /bin/terraform-provider-consul \
	   /bin/terraform-provider-datadog \
	   /bin/terraform-provider-digitalocean \
	   /bin/terraform-provider-dme \
	   /bin/terraform-provider-dnsimple \
	   /bin/terraform-provider-dyn \
	   /bin/terraform-provider-github \
	   /bin/terraform-provider-google \
	   /bin/terraform-provider-heroku \
	   /bin/terraform-provider-influxdb \
	   /bin/terraform-provider-mailgun \
	   /bin/terraform-provider-mysql \
	   /bin/terraform-provider-openstack \
	   /bin/terraform-provider-packet \
	   /bin/terraform-provider-postgresql \
	   /bin/terraform-provider-powerdns \
	   /bin/terraform-provider-rundeck \
	   /bin/terraform-provider-statuscake \
	   /bin/terraform-provider-triton \
	   /bin/terraform-provider-ultradns \
	   /bin/terraform-provider-vcd \
	   /bin/terraform-provider-vsphere


ENTRYPOINT ["/bin/terraform"]

VOLUME ["/data"]
WORKDIR /data
