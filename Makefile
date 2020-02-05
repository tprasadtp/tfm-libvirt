SHELL := /bin/bash

.DEFAULT_GOAL := help

# Set install prefix if not set already
TERRAFORM_PLUGIN_INSTALL_PREFIX ?= $(HOME)

# Get directory of makefile without trailing slash
ROOT_DIR := $(patsubst %/, %, $(dir $(realpath $(firstword $(MAKEFILE_LIST)))))

TERRAFORM_PLUGIN_INSTALL_DIR := $(patsubst %/, %, $(TERRAFORM_PLUGIN_INSTALL_PREFIX))

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

.PHONY: assert-ubuntu
assert-ubuntu: ## Assert Ubuntu+cloud-init Tests
	@echo -e "\033[92m➜ $@ \033[0m"
	(cd test && ansible-playbook ubuntu/assert.yml)

.PHONY: assert-centos
assert-centos: ## Assert CentOS+cloud-init Tests
	@echo -e "\033[92m➜ $@ \033[0m"
	(cd test && ansible-playbook centos/assert.yml)


.PHONY: install-assert-deps
install-assert-deps: ## Install assert python deps
	@echo -e "\033[92m➜ $@ \033[0m"
	pip3 install --user -r tests/requirements.txt


.PHONY: install-provider
install-provider: ## Installs Provider
	@echo -e "\033[92m➜ $@ \033[0m"
	@mkdir -p $(TERRAFORM_PLUGIN_INSTALL_DIR)/.terraform.d/plugins
	@mkdir -p $(ROOT_DIR)/vendor
	curl -sfL https://github.com/dmacvicar/terraform-provider-libvirt/releases/download/v0.6.1/terraform-provider-libvirt-0.6.1+git.1578064534.db13b678.Ubuntu_18.04.amd64.tar.gz -o $(ROOT_DIR)/vendor/terraform-provider-libvirt.tar.gz
	tar -C $(TERRAFORM_PLUGIN_INSTALL_DIR)/.terraform.d/plugins -xvzf $(ROOT_DIR)/vendor/terraform-provider-libvirt.tar.gz terraform-provider-libvirt

.PHONY: docs
docs: ## Generate module documentation
	@echo -e "\033[92m➜ $@ \033[0m"
	terraform-docs --sort-by-required markdown $(ROOT_DIR)/modules/vm > $(ROOT_DIR)/modules/vm/README.md
	terraform-docs --sort-by-required markdown $(ROOT_DIR)/modules/net > $(ROOT_DIR)/modules/net/README.md
