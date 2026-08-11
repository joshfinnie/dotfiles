# -------------------------------
# Homebrew
# -------------------------------
if test -x /opt/homebrew/bin/brew
    eval (/opt/homebrew/bin/brew shellenv)
end

# -------------------------------
# Only run the rest in interactive sessions
# -------------------------------
if status is-interactive

    # ---------------------------
    # Load asdf FIRST
    # ---------------------------
    if command -q brew
        set asdf_prefix (brew --prefix asdf 2>/dev/null)
        if test -f $asdf_prefix/libexec/asdf.fish
            source $asdf_prefix/libexec/asdf.fish
        end
    end

    # -------------------------------
    # PATH additions (AFTER asdf)
    # -------------------------------
    fish_add_path $HOME/.cargo/bin
    fish_add_path $HOME/go/bin
    fish_add_path $HOME/.local/bin

    nvm use default >/dev/null 2>&1

    set -gx EDITOR nvim
    set -gx FZF_DEFAULT_COMMAND 'ag -g "" --hidden --ignore .git'

    source $HOME/.config/fish/conf.d/abbr.fish

    if command -q starship
        starship init fish | source
    end

end


# Added by Antigravity CLI installer
set -gx PATH "/Users/josh/.local/bin" $PATH
