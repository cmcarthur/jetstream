FROM ubuntu:14.04

RUN apt-get update && \
	apt-get --assume-yes install unzip wget build-essential ruby-full

RUN wget 'https://releases.hashicorp.com/terraform/0.6.15/terraform_0.6.15_linux_amd64.zip' -P /tmp && \
	unzip /tmp/terraform_0.6.15_linux_amd64.zip -d /usr/bin/ && \
	rm /tmp/terraform_0.6.15_linux_amd64.zip

RUN rm /usr/bin/terraform-provider-atlas \
	   /usr/bin/terraform-provider-azure \
	   /usr/bin/terraform-provider-azurerm \
	   /usr/bin/terraform-provider-chef \
	   /usr/bin/terraform-provider-clc \
	   /usr/bin/terraform-provider-cloudflare \
	   /usr/bin/terraform-provider-cloudstack \
	   /usr/bin/terraform-provider-consul \
	   /usr/bin/terraform-provider-datadog \
	   /usr/bin/terraform-provider-digitalocean \
	   /usr/bin/terraform-provider-dme \
	   /usr/bin/terraform-provider-dnsimple \
	   /usr/bin/terraform-provider-dyn \
	   /usr/bin/terraform-provider-github \
	   /usr/bin/terraform-provider-google \
	   /usr/bin/terraform-provider-heroku \
	   /usr/bin/terraform-provider-influxdb \
	   /usr/bin/terraform-provider-mailgun \
	   /usr/bin/terraform-provider-mysql \
	   /usr/bin/terraform-provider-openstack \
	   /usr/bin/terraform-provider-packet \
	   /usr/bin/terraform-provider-postgresql \
	   /usr/bin/terraform-provider-powerdns \
	   /usr/bin/terraform-provider-rundeck \
	   /usr/bin/terraform-provider-statuscake \
	   /usr/bin/terraform-provider-triton \
	   /usr/bin/terraform-provider-ultradns \
	   /usr/bin/terraform-provider-vcd

RUN gem install bundler rubygems-bundler --no-rdoc --no-ri

COPY cli/Gemfile* /tmp/
WORKDIR /tmp
RUN bundle install

ENTRYPOINT ["/data/cli/bin/jet"]

VOLUME ["/data"]
VOLUME ["/workdir"]

WORKDIR /workdir
