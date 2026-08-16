if (( ${+FAST_HIGHLIGHT_STYLES} )); then
    typeset -gA _fsh_pal=(
        pink   "#f7b1de"
        purple "#c9a4ff"
        violet "#ddc4ff"
        blue   "#bcccff"
        green  "#b8e6b8"
        yellow "#ecdf63"
        cyan   "#a8e0e6"
        red    "#ffb4ab"
        gray   "#9b8d94"
    )

    for _k in command builtin function alias suffix-alias global-alias \
              hashed-command precommand subcommand; do
        FAST_HIGHLIGHT_STYLES[$_k]="fg=${_fsh_pal[pink]}"
    done

    for _k in single-quoted-argument double-quoted-argument dollar-quoted-argument; do
        FAST_HIGHLIGHT_STYLES[$_k]="fg=${_fsh_pal[green]}"
    done

    FAST_HIGHLIGHT_STYLES[bracket-level-1]="fg=${_fsh_pal[purple]},bold"
    FAST_HIGHLIGHT_STYLES[bracket-level-2]="fg=${_fsh_pal[violet]},bold"
    FAST_HIGHLIGHT_STYLES[bracket-level-3]="fg=${_fsh_pal[blue]},bold"
    FAST_HIGHLIGHT_STYLES[single-sq-bracket]="fg=${_fsh_pal[purple]}"
    FAST_HIGHLIGHT_STYLES[double-sq-bracket]="fg=${_fsh_pal[purple]}"
    FAST_HIGHLIGHT_STYLES[double-paren]="fg=${_fsh_pal[purple]}"
    FAST_HIGHLIGHT_STYLES[assign-array-bracket]="fg=${_fsh_pal[purple]}"

    FAST_HIGHLIGHT_STYLES[single-hyphen-option]="fg=${_fsh_pal[cyan]}"
    FAST_HIGHLIGHT_STYLES[double-hyphen-option]="fg=${_fsh_pal[cyan]}"
    FAST_HIGHLIGHT_STYLES[reserved-word]="fg=${_fsh_pal[yellow]}"
    FAST_HIGHLIGHT_STYLES[unknown-token]="fg=${_fsh_pal[red]},bold"
    FAST_HIGHLIGHT_STYLES[comment]="fg=${_fsh_pal[gray]}"
    FAST_HIGHLIGHT_STYLES[path]="none"
    FAST_HIGHLIGHT_STYLES[path-to-dir]="none,underline"
    unset _k
fi
