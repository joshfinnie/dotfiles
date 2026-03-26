DOTFILES := $(shell pwd)

.PHONY: all bash zsh fish tmux vim nvim js wezterm \
        packages homebrew-packages node-packages python-packages rust-packages go-packages

all: bash zsh fish tmux vim nvim js wezterm

# Usage: $(call symlink,src,dst)
define symlink
	@mkdir -p $$(dirname $(2))
	@if [ -L $(2) ]; then \
		echo "already linked: $(2)"; \
	elif [ -e $(2) ]; then \
		echo "backing up: $(2) -> $(2).bak"; \
		mv $(2) $(2).bak; \
		ln -s $(1) $(2); \
		echo "linked: $(2)"; \
	else \
		ln -s $(1) $(2); \
		echo "linked: $(2)"; \
	fi
endef

bash:
	$(call symlink,$(DOTFILES)/bash/aliases,$(HOME)/.aliases)
	$(call symlink,$(DOTFILES)/bash/bash_profile,$(HOME)/.bash_profile)
	$(call symlink,$(DOTFILES)/bash/bashrc,$(HOME)/.bashrc)
	$(call symlink,$(DOTFILES)/bash/profile,$(HOME)/.profile)

zsh:
	$(call symlink,$(DOTFILES)/zsh/zshrc,$(HOME)/.zshrc)
	$(call symlink,$(DOTFILES)/zsh/joshfinnie.zsh-theme,$(HOME)/.oh-my-zsh/custom/themes/joshfinnie.zsh-theme)

fish:
	$(call symlink,$(DOTFILES)/fish/config.fish,$(HOME)/.config/fish/config.fish)
	$(call symlink,$(DOTFILES)/fish/fish_variables,$(HOME)/.config/fish/fish_variables)
	$(call symlink,$(DOTFILES)/fish/conf.d,$(HOME)/.config/fish/conf.d)
	$(call symlink,$(DOTFILES)/fish/functions,$(HOME)/.config/fish/functions)

tmux:
	$(call symlink,$(DOTFILES)/tmux/tmux.conf,$(HOME)/.tmux.conf)

vim:
	$(call symlink,$(DOTFILES)/vim/vimrc,$(HOME)/.vimrc)

nvim:
	$(call symlink,$(DOTFILES)/nvim,$(HOME)/.config/nvim)

js:
	$(call symlink,$(DOTFILES)/js/jshintrc,$(HOME)/.jshintrc)

wezterm:
	$(call symlink,$(DOTFILES)/wezterm,$(HOME)/.config/wezterm)

# packages

packages: homebrew-packages node-packages python-packages rust-packages go-packages

homebrew-packages:
	@grep -v '^\s*#' $(DOTFILES)/homebrew/packages | grep -v '^\s*$$' | xargs brew install
	@grep -v '^\s*#' $(DOTFILES)/homebrew/casks    | grep -v '^\s*$$' | xargs brew install --cask

node-packages:
	@grep -v '^\s*#' $(DOTFILES)/node/packages | grep -v '^\s*$$' | xargs npm install -g

python-packages:
	@grep -v '^\s*#' $(DOTFILES)/python/packages | grep -v '^\s*$$' | xargs pip install

rust-packages:
	@grep -v '^\s*#' $(DOTFILES)/rust/packages | grep -v '^\s*$$' | while read pkg; do cargo install $$pkg; done

go-packages:
	@grep -v '^\s*#' $(DOTFILES)/go/packages | grep -v '^\s*$$' | while read pkg; do go install $$pkg; done
