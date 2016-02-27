function __z_update_completions -d "Update fish-completions"
  set -x __z_marks (cat $Z_DATA | sed "s/|.*//" | tr '\n' ' ')
  complete -c z -a $__z_marks -f
end
