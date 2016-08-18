function __z_complete -d "add completions"  
  set -l __z_marks (cat $Z_DATA | sed -e "s/|.*//" -e "s/^.*\$/\"&\"/g" | tr '\n' ' ')
  complete -c $Z_CMD -a $__z_marks -f
  complete -c $ZO_CMD -a $__z_marks -f
end
