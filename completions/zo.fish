set -l __z_marks (cat $Z_DATA | sed "s/|.*//" | tr '\n' ' ')
complete -c zo -a $__z_marks -f
