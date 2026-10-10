# -------------------------------
# Homebrew
# -------------------------------
for brew in /opt/homebrew/bin/brew /home/linuxbrew/.linuxbrew/bin/brew
    if test -x $brew
        $brew shellenv fish | source
        break
    end
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
    fish_add_path -g $HOME/.cargo/bin
    fish_add_path -g $HOME/go/bin

    nvm use default >/dev/null 2>&1

    set -gx EDITOR nvim
    set -gx FZF_DEFAULT_COMMAND 'ag -g "" --hidden --ignore .git'

    if command -q starship
        starship init fish | source
    end

end

# -------------------------------
# PATH additions (all shells)
# -------------------------------
fish_add_path -g $HOME/.local/bin

if test (uname) = Darwin
    set -gx PNPM_HOME $HOME/Library/pnpm
else
    set -gx PNPM_HOME $HOME/.local/share/pnpm
end
fish_add_path -g $PNPM_HOME $PNPM_HOME/bin
