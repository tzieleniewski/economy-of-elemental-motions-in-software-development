SHELL := /bin/bash

.DEFAULT_GOAL := help
.PHONY: help setup-all setup-git setup-java system-upgrade

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

setup: setup-git setup-java ## Setups everything

setup-git: ## Configures git aliases
	@echo --- $@ ---; \
	git config --global alias.br branch; \
	git config --global alias.ci commit; \
	git config --global alias.co checkout; \
	git config --global alias.pu 'pull --all --rebase'; \
	git config --global alias.st status

setup-java: setup-java-jenv setup-java-sdkman ## Setups everything for Java

setup-java-jenv: ## Installs jEnv
	@echo --- $@ ---; \
	git https://github.com/jenv/jenv.git ~/.jenv; \
	echo 'export PATH="${HOME}/.jenv/bin:${PATH}"' >> ~/.bashrc; \
	echo 'eval "$(jenv init -)"' >> ~/.bashrc; \
	echo 'export PATH="${HOME}/.jenv/bin:${PATH}"' >> ~/.zshrc; \
    echo 'eval "$(jenv init -)"' >> ~/.zshrc

setup-java-sdkman: ## Installs SDKMAN with OpenJDK 11, 17 and latest Maven
	@echo --- $@ ---; \
	curl -s "https://get.sdkman.io" | bash; \
	source "/home/tkz/.sdkman/bin/sdkman-init.sh"; \
	sdk selfupdate; \
	sdk install java 11.0.12-open; \
	sdk install java 17.0.1-open; \
	rm ~/.sdkman/candidates/java/current; \
	sdk install maven; \
	sdk update

system-upgrade: ## Upgrades and cleans system packages
	@echo --- $@ ---; \
	sudo apt update; \
	sudo apt upgrade; \
	sudo apt clean
