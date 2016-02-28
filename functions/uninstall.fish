functions -e __z_on_variable_pwd
functions -e $Z_CMD

printf "$Z_DATA will be left intact...\n"
printf "to remove, simply delete it\n"

#Unset variables
set -e Z_CMD
set -e Z_DATA
set -e Z_EXCLUDE
