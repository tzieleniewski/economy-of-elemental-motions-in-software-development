SHELL := /bin/bash

.DEFAULT_GOAL := help

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: setup
setup: setup-git setup-java ## Setups everything

.PHONY: setup-docker
setup-docker: ## Installs Docker Engine
	@echo --- $@ ---
	curl -fsSL https://get.docker.com | sudo bash

.PHONY: setup-git
setup-git: ## Configures git aliases
	@echo --- $@ ---
	git config --global alias.br branch; \
	git config --global alias.ci commit; \
	git config --global alias.co checkout; \
	git config --global alias.pu 'pull --all --rebase'; \
	git config --global alias.st status

.PHONY: setup-github
setup-github: ## Installs act
	@echo --- $@ ---
	curl https://raw.githubusercontent.com/nektos/act/master/install.sh | sudo bash

.PHONY: setup-java
setup-java: setup-java-jenv setup-java-sdkman ## Setups everything for Java

.PHONY: setup-java-jenv
setup-java-jenv: ## Installs jEnv
	@echo --- $@ ---
	git clone https://github.com/jenv/jenv.git ~/.jenv; \
	echo 'export PATH="${HOME}/.jenv/bin:${PATH}"' >> ~/.bashrc; \
	echo 'eval "$(jenv init -)"' >> ~/.bashrc; \
	echo 'export PATH="${HOME}/.jenv/bin:${PATH}"' >> ~/.zshrc; \
    echo 'eval "$(jenv init -)"' >> ~/.zshrc

.PHONY: setup-java-sdkman
setup-java-sdkman: ## Installs SDKMAN with OpenJDK 11, 17 and latest Maven
	@echo --- $@ ---
	curl -s "https://get.sdkman.io" | bash; \
	source "/home/tkz/.sdkman/bin/sdkman-init.sh"; \
	sdk selfupdate; \
	sdk install java 17.0.7-tem; \
	rm ~/.sdkman/candidates/java/current; \
	sdk update

.PHONY: setup-k8s
setup-k8s: ## Installs kubectl, k9s, krew & Rancher Desktop
	@echo --- $@ ---
	curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-archive-keyring.gpg; \
	echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list; \
	sudo apt-get update; \
    sudo apt-get install -y kubectl; \
    k krew install ctx; \
    k krew install ns; \
#	k9s
#	rancher

.PHONY: setup-shell
setup-shell: ## Installs Oh My Zsh & Powerlevel10k
	@echo --- $@ ---
	sudo apt install fzf; \
	sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"; \
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

.PHONY: system-upgrade
system-upgrade: ## Upgrades and cleans system packages
	@echo --- $@ ---
	sudo apt update
	sudo apt upgrade
	sudo apt clean
