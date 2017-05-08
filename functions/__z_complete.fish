function __z_complete -d "add completions"
  set -l __z_marks (string replace -r '\|.*' '' < $Z_DATA | string escape)

  complete -c $Z_CMD -a "$__z_marks" -f
  complete -c $ZO_CMD -a "$__z_marks" -f
end
