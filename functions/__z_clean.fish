function __z_clean -d "Clean up .z file to remove paths no longer valid"
  set -l tmpfile (mktemp $Z_DATA.XXXXXX)

  if test -f $tmpfile
    command awk -F "|" 'system("test -d \"" $1 "\"") == 0 { print $0 }' $Z_DATA > $tmpfile
    command mv -f $tmpfile $Z_DATA
  end

  __z_complete
end
