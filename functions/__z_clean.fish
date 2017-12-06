function __z_clean -d "Clean up .z file to remove paths no longer valid"
  set -l path (command dirname (status -f))
  set -l tmpfile (mktemp $Z_DATA.XXXXXX)

  if test -f $tmpfile
    command awk -F "|" -f $path/zclean.awk $Z_DATA > $tmpfile
    command mv -f $tmpfile $Z_DATA
  end

  __z_complete
end
