function z -d "Jump to a recent directory."
  set -l option
  set -l list
  set -l args
  set -l typ ''
  set -l list 0
  set -g z_path (dirname (status -f))
  
  getopts $argv | while read -l 1 2
    switch $1
      case e echo
        set option ech
        set args "$2"
        break
      case l list
        set option list
        set args "$2"
        break
      case r rank
        set typ "rank"
        set args "$2"
        break
      case t recent
        set typ "recent"
        set args "$2"
        break
      case _
        set args "$2"
        break
      case h help
        printf "Usage: z  [--list] [--rank] [--recent] [--help]\n\n"
        printf "         -e --echo     Echo best match without changing directory\n"
        printf "         -l --list     List matches without changing directory\n"
        printf "         -r --rank     Searches and changes directory by rank\n"
        printf "         -t --recent   Search and changes directory by recency\n"
        printf "         -h --help     Print this help"
        return 0
      case \*
        printf "z: '%s' is not a valid option\n" $1
        z --help
        return 1
    end
  end
  
  set -l target (awk -v t=(date +%s) -v option="$option" -v typ="$typ" -v q="$args" -F "|" -f $z_path/z.awk "$Z_DATA")

  if test "$status" -gt 0
    return
  end

  if test -z "$target"
    printf "'%s' did not match any results" "$args"
    return 1
  end

  if contains -- ech $option
    printf "%s\n" "$target"
  else if not contains -- list $option
    cd "$target"
  end
end
