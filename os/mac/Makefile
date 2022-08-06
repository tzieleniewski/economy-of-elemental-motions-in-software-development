SHELL := /bin/bash

.DEFAULT_GOAL := help

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: setup-all
setup-all: setup-brew setup-git setup-java setup-k8s setup-tools ## Setups everything

.PHONY: setup-aws
setup-aws: ## Installs AWS CLI
	@echo --- $@ ---
	brew install awscli

.PHONY: setup-brew
setup-brew: ## Installs Homebrew
	@echo --- $@ ---
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

.PHONY: setup-git
setup-git: ## Installs git, tig and configures git aliases
	@echo --- $@ ---
	brew install git
	brew install tig
	git config --global alias.br branch
	git config --global alias.ci commit
	git config --global alias.co checkout
	git config --global alias.pu 'pull --all --rebase'
	git config --global alias.st status

.PHONY: setup-github
setup-github: ## Installs act
	@echo --- $@ ---
	curl https://raw.githubusercontent.com/nektos/act/master/install.sh | sudo bash

.PHONY: setup-java
setup-java: setup-java-jenv setup-java-jetbrains setup-java-sdkman ## Setups everything for Java

.PHONY: setup-java-jenv
setup-java-jenv: ## Installs jEnv
	@echo --- $@ ---
	git https://github.com/jenv/jenv.git ~/.jenv
	echo 'export PATH="${HOME}/.jenv/bin:${PATH}"' >> ~/.bashrc
	echo 'eval "$(jenv init -)"' >> ~/.bashrc
	echo 'export PATH="${HOME}/.jenv/bin:${PATH}"' >> ~/.zshrc
	echo 'eval "$(jenv init -)"' >> ~/.zshrc

.PHONY: setup-java-jetbrains
setup-java-jetbrains: ## Installs Jetbrains Toolbox
	@echo --- $@ ---
	brew install --cask jetbrains-toolbox

.PHONY: setup-java-sdkman
setup-java-sdkman: ## Installs SDKMAN with OpenJDK 11, 17 & latest Gradle & Maven
	@echo --- $@ ---
	curl -s "https://get.sdkman.io" | bash
	source "/home/tkz/.sdkman/bin/sdkman-init.sh"
	sdk selfupdate
	sdk install java 11.0.12-open
	sdk install java 17.0.1-open
	rm ~/.sdkman/candidates/java/current
	sdk install gradle
	sdk install maven
	sdk update

.PHONY: setup-k8s
setup-k8s: ## Installs kubectl, k9s, krew & Rancher Desktop
	@echo --- $@ ---
	brew install kubectl
	brew install k9s
	brew install krew
	kubectl install ctx
	kubectl install ns
	brew install --cask rancher

.PHONY: setup-shell
setup-shell: ## Installs Oh My Zsh & Powerlevel10k
	@echo --- $@ ---
	sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

.PHONY: setup-tools
setup-tools: ## Installs HTTPie, Wget & Todoist
	@echo --- $@ ---
	brew install httpie
	brew install wget
	brew install --cask todoist
