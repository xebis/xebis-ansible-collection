# shellcheck shell=bash
BASH_ALIASES_EXTRA="$HOME/.config/*.bash_aliases"

mkcd() {
    # shellcheck disable=SC2164
    mkdir -p -- "$1" && cd -P -- "$1"
}

if compgen -G "$BASH_ALIASES_EXTRA"; then
    for bash_aliases_file in $BASH_ALIASES_EXTRA; do
        # shellcheck disable=SC1090
        . "$bash_aliases_file"
    done
fi
