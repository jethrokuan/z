function __zo -d "Jump to a recent directory."
  set -l option
  set -l arg
  set -l typ ''
  set -g z_path (command dirname (status -f))
  set -l target

  getopts $argv | while read -l 1 2
    switch $1
      case _
        set arg "$2"
        break
      case h help
        printf "Usage: $ZO_CMD dir\n\n"
        printf "To use a different open command, set $ZO_METHOD:\n"
        printf "   set -U ZO_METHOD \"opencmd\"\n\n"
        printf "         -h --help     Print this help"
        return 0
      case \*
        printf "$ZO_CMD: '%s' is not a valid option\n" $1
        __z --help
        return 1
    end
  end

  if test 1 -eq (printf "%s" $arg | grep -c "^\/")
    set target $arg
  else
    set target (command awk -v t=(date +%s) -v option="$option" -v typ="$typ" -v q="$arg" -F "|" -f $z_path/z.awk "$Z_DATA")
  end

  if test -z "$target"
    printf "'%s' did not match any results" "$arg"
    return 1
  else
    if test ! -z "$ZO_METHOD"
      eval "$ZO_METHOD" "$target"; return 0;
    else
      type -q xdg-open;and xdg-open "$target"; and return $status;
      type -q open;and open "$target"; and return $status;
      echo "Not sure how to open file manager"; and return 1;
    end
  end
end
