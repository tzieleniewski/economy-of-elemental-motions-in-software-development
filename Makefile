SHELL := /bin/bash

.DEFAULT_GOAL := help

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

git-setup: ## Sets git aliases
	git config --global alias.br branch
	git config --global alias.ci commit
	git config --global alias.co checkout
	git config --global alias.pu 'pull --all --rebase'
	git config --global alias.st status

java-setup: ## Installs SDKMAN with OpenJDK 11, 17 and latest Maven
	curl -s "https://get.sdkman.io" | bash
	source "/home/tkz/.sdkman/bin/sdkman-init.sh"
	sdk install java 11.0.12-open
	sdk install java 17.0.1-open
	rm ~/.sdkman/candidates/java/current
	sdk install maven
	sdk update

system-upgrade: ## Upgrades and clean system packages
	sudo apt update
	sudo apt upgrade
	sudo apt clean