.PHONY: install ssh

install:
	bin/install.sh

build:
	docker build -t cmcarthur/jetstream .
