function __z -d "Jump to a recent directory."
  set -l option
  set -l arg
  set -l typ ''
  set -g z_path (command dirname (status -f))
  set -l target

  getopts $argv | while read -l 1 2
    switch $1
      case c clean
        echo > $Z_DATA
        printf "%s cleaned!" $Z_DATA
        return 0
      case e echo
        set option "ech"
        set arg "$2"
        break
      case l list
        set option "list"
        set arg "$2"
        break
      case r rank
        set typ "rank"
        set arg "$2"
        break
      case t recent
        set typ "recent"
        set arg "$2"
        break
      case _
        set arg "$2"
        break
      case h help
        printf "Usage: $Z_CMD  [-celrth] dir\n\n"
        printf "         -c --clean    Cleans out $Z_DATA\n"
        printf "         -e --echo     Prints best match, no cd\n"
        printf "         -l --list     List matches, no cd\n"
        printf "         -r --rank     Search by rank, cd\n"
        printf "         -t --recent   Search by recency, cd\n"
        printf "         -h --help     Print this help\n\n"
        printf "If installed with fisherman, run `fisher help z` for more info"
          return 0
      case \*
        printf "$Z_CMD: '%s' is not a valid option\n" $1
        __z --help
        return 1
        end
    end

    if test 1 -eq (printf "%s" $arg | grep -c "^\/")
      set target $arg
    else
      set target (command awk -v t=(date +%s) -v option="$option" -v typ="$typ" -v q="$arg" -F "|" -f $z_path/z.awk "$Z_DATA") 
    end

    if test "$option" = "list"
      echo "$target" | tr ";" "\n" | sort -nr
      return 0
    end

    if test "$status" -gt 0
      return
    end

    if test -z "$target"
      printf "'%s' did not match any results" "$arg"
      return 1
    end

    if contains -- ech $option
      printf "%s\n" "$target"
    else if not contains -- list $option
      pushd "$target"
    end
  end
