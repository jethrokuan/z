functions -e __z_on_variable_pwd
functions -e $Z_CMD
functions -e $ZO_CMD

if test ! -z "$Z_DATA"
    printf "To completely erase z's data, remove:\n" > /dev/stderr
    printf "%s\n" "$Z_DATA" > /dev/stderr
end

set -e Z_CMD
set -e ZO_CMD
set -e Z_DATA
set -e Z_EXCLUDE
