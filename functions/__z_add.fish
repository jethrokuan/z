function __z_add -d "Add PATH to .z file"
  set -l path (command dirname (status -f))

  for i in $Z_EXCLUDE
    if contains -- $PWD $i
      return 0 #Path excluded
    end
  end

  set -l tmpfile (mktemp $Z_DATA.XXXXXX)

  if test -f $tmpfile
    command awk -v path="$PWD" -v now=(date +%s) -F "|" -f $path/zadd.awk $Z_DATA ^ /dev/null > $tmpfile
    command mv -f $tmpfile $Z_DATA
  end

  __z_complete
end
