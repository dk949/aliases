export INIT_NIX_TEMPLATES_DIR="${INIT_NIX_TEMPLATES_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/nix-templates}"

alias nixb='nix build'
alias nixr='nix run'
alias nixd='nix develop -c $SHELL'
alias nixfu='nix flake update'
alias nixfc='nix flake check'
alias nixs='nix search nixpkgs'

init-nix() {
    # Rolling release URL. Stable across releases.
    local init_nix_template_url="https://github.com/dk949/nix-templates/releases/download/latest/templates.tar.gz"

    # -h, --help: show usage and exit
    if [[ "$1" == "-h" ]] || [[ "$1" == "--help" ]]; then
        cat <<'EOF'
init-nix: scaffold a project from a template

Templates are auto-fetched into $INIT_NIX_TEMPLATES_DIR on first use.

Usage:
  init-nix                      list available templates
  init-nix -h, --help           show this help
  init-nix -c, --clear-cache    remove the cached templates dir
  init-nix <template>           scaffold into current directory
  init-nix <template> <dir>     scaffold into <dir> (must be empty or missing)
EOF
        return 0
    fi

    # --clear-cache: wipe the cache and exit
    if [[ "$1" == "--clear-cache" ]] || [[ "$1" == "-c" ]]; then
        if [[ -d "$INIT_NIX_TEMPLATES_DIR" ]]; then
            rm -rf "$INIT_NIX_TEMPLATES_DIR"
            echo "init-nix: cleared $INIT_NIX_TEMPLATES_DIR"
        else
            echo "init-nix: cache already empty ($INIT_NIX_TEMPLATES_DIR)"
        fi
        return 0
    fi

    # Auto-fetch if the cache is missing or empty
    if [[ ! -d "$INIT_NIX_TEMPLATES_DIR" ]] || [[ -z "$(\ls -A -- "$INIT_NIX_TEMPLATES_DIR" 2>/dev/null)" ]]; then
        echo "init-nix: fetching templates into $INIT_NIX_TEMPLATES_DIR"
        mkdir -p "$INIT_NIX_TEMPLATES_DIR"
        if ! curl -fsSL "$init_nix_template_url" | tar -xz -C "$INIT_NIX_TEMPLATES_DIR"; then
            echo "init-nix: fetch failed from $init_nix_template_url" >&2
            return 1
        fi
    fi

    local template="$1"
    local target="${2:-.}"

    if [[ -z "$template" ]]; then
        echo "Available templates in $INIT_NIX_TEMPLATES_DIR:"
        # shellcheck disable=SC2012  # template names are simple, ls output is fine
        \ls -1 "$INIT_NIX_TEMPLATES_DIR" | sed 's/^/  /'
        echo
        echo "Usage: init-nix <template> [target-dir]"
        return 1
    fi

    local src="$INIT_NIX_TEMPLATES_DIR/$template"
    if [[ ! -d "$src" ]]; then
        echo "init-nix: template '$template' not found in $INIT_NIX_TEMPLATES_DIR" >&2
        return 1
    fi

    # Refuse to scaffold into a non-empty directory
    if [[ -d "$target" ]] && [[ -n "$(\ls -A -- "$target" 2>/dev/null)" ]]; then
        echo "init-nix: $target is not empty, refusing to scaffold" >&2
        return 1
    fi

    mkdir -p "$target"

    # Copy contents (including dotfiles) preserving attributes
    cp -a "$src/." "$target/"

    # Initialize git if not already a repo (so flake.lock can be tracked cleanly)
    if [[ ! -d "$target/.git" ]] && command -v git >/dev/null 2>&1; then
        git -C "$target" init -q
        git -C "$target" add -A
    fi

    # Allow direnv if available
    if command -v direnv >/dev/null 2>&1 && [[ -f "$target/.envrc" ]]; then
        direnv allow "$target/.envrc"
    fi

    echo "Scaffolded '$template' into $target"
    echo "Next: cd $target && nix develop   (or just cd in if direnv is active)"
}
