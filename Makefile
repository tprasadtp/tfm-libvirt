SHELL := /bin/bash

# Get directory of makefile without trailing slash
ROOT_DIR := $(patsubst %/, %, $(dir $(realpath $(firstword $(MAKEFILE_LIST)))))


.DEFAULT_GOAL := help

# Set install prefix if not set already
LIBVIRT_PLUGIN_DIR := $(HOME)/.local/share/terraform/plugins/local.tprasadtp.github.io/local/libvirt/0.6.2/linux_amd64/

# Image download prefix
CLOUD_IMAGE_DOWNLOAD_PATH ?= $(HOME)/Virtual/installers/cloudimages


.PHONY: help
help: ## This help dialog.
	@IFS=$$'\n' ; \
		help_lines=(`fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/$$//' | sed -e 's/##/:/'`); \
		printf "%-30s %s\n" "--------" "------------" ; \
		printf "%-30s %s\n" " Target " "    Help " ; \
		printf "%-30s %s\n" "--------" "------------" ; \
		for help_line in $${help_lines[@]}; do \
			IFS=$$':' ; \
			help_split=($$help_line) ; \
			help_command=`echo $${help_split[0]} | sed -e 's/^ *//' -e 's/ *$$//'` ; \
			help_info=`echo $${help_split[2]} | sed -e 's/^ *//' -e 's/ *$$//'` ; \
			printf "\033[92m"; \
			printf "%-30s %s" $$help_command ; \
			printf "\033[0m"; \
			printf "%s\n" $$help_info; \
		done


.PHONY: lint
lint: fmt-lint validate ## Lint everything
	@echo -e "\033[92m➜ $@ \033[0m"


.PHONY: validate
validate: ## Terraform Validate
	@echo -e "\033[92m➜ $@ \033[0m"
	terraform init $(ROOT_DIR)/modules/vm
	terraform validate $(ROOT_DIR)/modules/vm
	terraform init $(ROOT_DIR)/modules/net
	terraform validate $(ROOT_DIR)/modules/net
	terraform init $(ROOT_DIR)/test/ubuntu
	terraform validate $(ROOT_DIR)/test/ubuntu


.PHONY: fmt
fmt: ## Terraform fmt
	@echo -e "\033[92m➜ $@ \033[0m"
	terraform fmt -recursive $(ROOT_DIR)


.PHONY: fmt-lint
fmt-lint: ## Terraform fmt lint
	@echo -e "\033[92m➜ $@ \033[0m"
	terraform fmt -check -recursive -diff $(ROOT_DIR)

.PHONY: test-ubuntu
test-ubuntu: ## Test Ubuntu+cloud-init Tests
	@echo -e "\033[92m➜ $@ \033[0m"
	cd $(ROOT_DIR)/test/ubuntu && terraform init && terraform apply -auto-approve
	ansible-playbook -i $(ROOT_DIR)/test/inventory.ini $(ROOT_DIR)/test/ubuntu/assert.yml
	cd $(ROOT_DIR)/test/ubuntu && terraform destroy -force

.PHONY: test-centos
test-centos: ## Test Centos+cloud-init Tests
	@echo -e "\033[92m➜ $@ \033[0m"
	cd $(ROOT_DIR)/test/centos && terraform init && terraform apply -auto-approve
	ansible-playbook -i $(ROOT_DIR)/test/inventory.ini $(ROOT_DIR)/test/centos/assert.yml
	cd $(ROOT_DIR)/test/centos && terraform destroy -force

.PHONY: install-provider
install-provider: ## Installs Provider
	@echo -e "\033[92m➜ $@ \033[0m"
	@mkdir -p $(LIBVIRT_PLUGIN_DIR)
	@mkdir -p $(ROOT_DIR)/vendor
	cd $(ROOT_DIR)/vendor && curl -sSfLO https://github.com/dmacvicar/terraform-provider-libvirt/releases/download/v0.6.2/terraform-provider-libvirt-0.6.2+git.1585292411.8cbe9ad0.Ubuntu_18.04.amd64.tar.gz
	cd $(ROOT_DIR)/vendor && curl -sSfLO https://github.com/dmacvicar/terraform-provider-libvirt/releases/download/v0.6.2/terraform-provider-libvirt-0.6.2.sha256
	cd $(ROOT_DIR)/vendor && sha256sum -c --quiet --ignore-missing terraform-provider-libvirt-0.6.2.sha256
	tar -C $(LIBVIRT_PLUGIN_DIR) \
		-xvzf $(ROOT_DIR)/vendor/terraform-provider-libvirt-0.6.2+git.1585292411.8cbe9ad0.Ubuntu_18.04.amd64.tar.gz \
		terraform-provider-libvirt

.PHONY: docs
docs: ## Generate module documentation
	@echo -e "\033[92m➜ $@ \033[0m"
	terraform-docs --sort-by-required markdown $(ROOT_DIR)/modules/vm > $(ROOT_DIR)/modules/vm/README.md
	terraform-docs --sort-by-required markdown $(ROOT_DIR)/modules/net > $(ROOT_DIR)/modules/net/README.md
