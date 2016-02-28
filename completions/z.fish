set -l __z_marks (cat $Z_DATA | sed "s/|.*//" | tr '\n' ' ')
complete -c z -a $__z_marks -f
