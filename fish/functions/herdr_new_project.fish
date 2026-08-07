function herdr_new_project --description 'Scaffold a herdr-plus project: claude+lazygit+terminal panes, plus an nvim tab'
    set -l dotfiles ~/src/p/dotfiles
    set -l projects_dir $dotfiles/herdr/projects

    if test (count $argv) -lt 1
        echo "Usage: herdr_new_project <name> [path] [description]" >&2
        return 1
    end

    set -l name $argv[1]
    set -l path $argv[2]
    set -l description $argv[3]

    if test -z "$path"
        set path (pwd)
    end
    set path (string replace -r '^'(string escape --style=regex -- $HOME) '~' -- $path)

    if test -z "$description"
        set description $name
    end

    set -l dest $projects_dir/$name.toml
    if test -e $dest
        echo "herdr project '$name' already exists at $dest" >&2
        return 1
    end

    printf '%s\n' \
        "name = \"$name\"" \
        "description = \"$description\"" \
        "working_dir = \"$path\"" \
        "" \
        "[[tabs]]" \
        "name = \"main\"" \
        "" \
        "[[tabs.panes]]" \
        "command = \"claude\"" \
        "" \
        "[[tabs.panes]]" \
        "command = \"lazygit\"" \
        "split = \"right\"" \
        "" \
        "[[tabs.panes]]" \
        "split = \"down\"" \
        "" \
        "[[tabs]]" \
        "name = \"nvim\"" \
        "command = \"nvim\"" \
        > $dest

    echo "Created $dest"
end
