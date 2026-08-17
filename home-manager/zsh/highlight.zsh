if (( ${+FAST_HIGHLIGHT_STYLES} )); then
    typeset -gA _fsh_pal=(
        red    "#d83e4a"
        orange "#f36630"
        green  "#86a87e"
        amber  "#ec8509"
        blue   "#4c6a84"
        gray   "#666666"
    )

    for _k in command builtin function alias suffix-alias global-alias \
              hashed-command precommand subcommand reserved-word; do
        FAST_HIGHLIGHT_STYLES[$_k]="fg=${_fsh_pal[red]}"
    done

    for _k in single-quoted-argument double-quoted-argument dollar-quoted-argument; do
        FAST_HIGHLIGHT_STYLES[$_k]="fg=${_fsh_pal[green]}"
    done

    FAST_HIGHLIGHT_STYLES[bracket-level-1]="fg=${_fsh_pal[amber]},bold"
    FAST_HIGHLIGHT_STYLES[bracket-level-2]="fg=${_fsh_pal[blue]},bold"
    FAST_HIGHLIGHT_STYLES[bracket-level-3]="fg=${_fsh_pal[gray]},bold"
    FAST_HIGHLIGHT_STYLES[single-sq-bracket]="fg=${_fsh_pal[amber]}"
    FAST_HIGHLIGHT_STYLES[double-sq-bracket]="fg=${_fsh_pal[amber]}"
    FAST_HIGHLIGHT_STYLES[double-paren]="fg=${_fsh_pal[amber]}"
    FAST_HIGHLIGHT_STYLES[assign-array-bracket]="fg=${_fsh_pal[amber]}"

    FAST_HIGHLIGHT_STYLES[single-hyphen-option]="fg=${_fsh_pal[blue]}"
    FAST_HIGHLIGHT_STYLES[double-hyphen-option]="fg=${_fsh_pal[blue]}"
    FAST_HIGHLIGHT_STYLES[unknown-token]="fg=${_fsh_pal[orange]},bold"
    FAST_HIGHLIGHT_STYLES[variable]="fg=${_fsh_pal[blue]}"
    FAST_HIGHLIGHT_STYLES[comment]="fg=${_fsh_pal[gray]}"
    FAST_HIGHLIGHT_STYLES[path]="none"
    FAST_HIGHLIGHT_STYLES[path-to-dir]="none,underline"
    unset _k
fi
