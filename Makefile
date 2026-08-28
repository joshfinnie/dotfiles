DOTFILES := $(shell pwd)

.PHONY: all bash zsh fish tmux vim nvim js wezterm zellij ghostty herdr claude codex antigravity \
        packages homebrew-packages node-packages python-packages rust-packages go-packages

all: bash zsh fish tmux vim nvim js wezterm zellij ghostty herdr claude codex antigravity

# Usage: $(call symlink,src,dst)
define symlink
	@mkdir -p $$(dirname $(2))
	@if [ -L $(2) ]; then \
		if [ "$$(readlink $(2))" = "$(1)" ]; then \
			echo "already linked: $(2)"; \
		else \
			rm $(2); \
			ln -s $(1) $(2); \
			echo "relinked: $(2)"; \
		fi; \
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
	$(call symlink,$(DOTFILES)/fish/fish_plugins,$(HOME)/.config/fish/fish_plugins)
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

zellij:
	$(call symlink,$(DOTFILES)/zellij,$(HOME)/.config/zellij)
	@curl -fsSL https://github.com/dj95/zjstatus/releases/latest/download/zjstatus.wasm \
		-o $(DOTFILES)/zellij/plugins/zjstatus.wasm

ghostty:
	$(call symlink,$(DOTFILES)/ghostty/config,$(HOME)/.config/ghostty/config)

herdr:
	$(call symlink,$(DOTFILES)/herdr/config.toml,$(HOME)/.config/herdr/config.toml)
	$(call symlink,$(DOTFILES)/herdr/projects,$(HOME)/.config/herdr/plugins/config/cloudmanic.herdr-plus/projects)
	# herdr-agent-quota runs from a local fork (github.com:joshfinnie/herdr-agent-quota,
	# branch claude-multi-account) that fixes concurrent Claude accounts sharing one
	# quota row. Clone it to ~/src/p/herdr-agent-quota, `cargo build --release`, then:
	#   herdr plugin link ~/src/p/herdr-agent-quota --enabled
	#   herdr plugin action invoke herdr-agent-quota.configure
	# Repeat the work profile's statusLine/session hooks with:
	#   CLAUDE_SETTINGS_FILE=~/.claude-work/settings.json HERDR_PLUGIN_STATE_DIR=~/.local/state/herdr/plugins/herdr-agent-quota \
	#     ~/src/p/herdr-agent-quota/target/release/herdr-agent-quota configure --apply
	#   CLAUDE_CONFIG_DIR=~/.claude-work herdr integration install claude

claude:
	$(call symlink,$(DOTFILES)/ai_agents/AGENTS.md,$(HOME)/.claude/CLAUDE.md)
	$(call symlink,$(DOTFILES)/ai_agents/skills,$(HOME)/.claude/skills)
	$(call symlink,$(DOTFILES)/ai_agents/AGENTS.md,$(HOME)/AGENTS.md)

codex:
	$(call symlink,$(DOTFILES)/ai_agents/skills,$(HOME)/.codex/skills)

antigravity:
	$(call symlink,$(DOTFILES)/ai_agents/skills,$(HOME)/.gemini/antigravity/skills)

# packages

packages: homebrew-packages node-packages python-packages rust-packages go-packages

homebrew-packages:
ifeq ($(shell uname),Darwin)
	@grep -v '^\s*#' $(DOTFILES)/homebrew/packages | grep -v '^\s*$$' | xargs brew install
	@grep -v '^\s*#' $(DOTFILES)/homebrew/casks    | grep -v '^\s*$$' | xargs brew install --cask
else
	@echo "skipping homebrew-packages: macOS only"
endif

node-packages:
	@grep -v '^\s*#' $(DOTFILES)/node/packages | grep -v '^\s*$$' | xargs npm install -g

python-packages:
	@grep -v '^\s*#' $(DOTFILES)/python/packages | grep -v '^\s*$$' | xargs pip install

rust-packages:
	@grep -v '^\s*#' $(DOTFILES)/rust/packages | grep -v '^\s*$$' | while read pkg; do cargo install $$pkg; done

go-packages:
	@grep -v '^\s*#' $(DOTFILES)/go/packages | grep -v '^\s*$$' | while read pkg; do go install $$pkg; done
