if test -z "$Z_DATA"
    if test -z "$XDG_DATA_HOME"
        set -U Z_DATA_DIR "$HOME/.local/share/z"
    else
        set -U Z_DATA_DIR "$XDG_DATA_HOME/z"
    end
    set -U Z_DATA "$Z_DATA_DIR/data"
end

if test ! -e "$Z_DATA"
    if test ! -e "$Z_DATA_DIR"
        mkdir -p -m 700 "$Z_DATA_DIR"
    end
    touch "$Z_DATA"
end

if not set -q Z_EXCLUDE
    set -U Z_EXCLUDE "^$HOME\$"
else if contains $HOME $Z_EXCLUDE
    # Workaround: migrate old default values to a regex (see #90).
    set Z_EXCLUDE (string replace -r -- "^$HOME\$" '^'$HOME'$$' $Z_EXCLUDE)
end

function __z_on_variable_pwd --on-variable PWD
    __z_add
end

function __z_uninstall --on-event z_uninstall
    functions -e __z_on_variable_pwd

    if test ! -z "$Z_DATA"
        printf "To completely erase z's data, remove:\n" >/dev/stderr
        printf "%s\n" "$Z_DATA" >/dev/stderr
    end

    set -e Z_DATA
    set -e Z_EXCLUDE
end
