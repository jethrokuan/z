function __z_complete -d "add completions"
  set -l __z_marks (awk '
    BEGIN { FS="|"}
    /1/ {print $1}
    ' < $Z_DATA)

  complete -c $Z_CMD -a "$__z_marks" -f
  complete -c $ZO_CMD -a "$__z_marks" -f
end
