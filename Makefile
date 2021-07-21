SHELL := /bin/bash
.DEFAULT_GOAL := help
export REPO_ROOT := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

.PHONY: help
help: ## This help message
	@printf "%-20s %s\n" "Target" "Help"
	@printf "%-20s %s\n" "-----" "-----"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

# Image download prefix
CLOUD_IMAGE_DOWNLOAD_PATH ?= $(HOME)/Virtual/installers


.PHONY: lint
lint: fmt-lint validate ## Lint everything
	@echo -e "\033[92m➜ $@ \033[0m"


.PHONY: validate
validate: ## Terraform Validate
	@echo -e "\033[92m➜ $@ \033[0m"
	terraform init $(REPO_ROOT)/modules/vm
	terraform validate $(REPO_ROOT)/modules/vm
	terraform init $(REPO_ROOT)/modules/net
	terraform validate $(REPO_ROOT)/modules/net
	terraform init $(REPO_ROOT)/test/ubuntu
	terraform validate $(REPO_ROOT)/test/ubuntu


.PHONY: fmt
fmt: ## Terraform fmt
	@echo -e "\033[92m➜ $@ \033[0m"
	terraform fmt -recursive $(REPO_ROOT)

.PHONY: fmt-lint
fmt-lint: ## Terraform fmt lint
	@echo -e "\033[92m➜ $@ \033[0m"
	terraform fmt -check -recursive -diff $(REPO_ROOT)

.PHONY: test-ubuntu
test-ubuntu: ## Test Ubuntu+cloud-init Tests
	@echo -e "\033[92m➜ $@ \033[0m"
	cd $(REPO_ROOT)/test/ubuntu && terraform init && terraform apply -auto-approve
	ansible-playbook -i $(REPO_ROOT)/test/inventory.ini $(REPO_ROOT)/test/assert.yml
	cd $(REPO_ROOT)/test/ubuntu && terraform destroy -auto-approve

.PHONY: docs
docs: ## Generate module documentation
	@echo -e "\033[92m➜ $@ \033[0m"
	@bash $(REPO_ROOT)/scripts/tf-docs.sh vm net
