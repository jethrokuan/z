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
    if test ! -z "$Z_OWNER"
      chown $Z_OWNER:(id -ng $Z_OWNER) "$tempfile"
    end
    #
    # Don't use redirection here as it can lead to a race condition where $Z_DATA is clobbered.
    # Note: There is a still a possible race condition where an old version of $Z_DATA is
    #       read by one instance of Fish before another instance of Fish writes its copy.
    #
    command mv $tmpfile $Z_DATA
    or command rm $tmpfile
  end

  __z_complete
end
