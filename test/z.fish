set pth $DIRNAME/$TESTNAME

function setup
  set -U Z_DATA "$pth/.z"
  mkdir -p $pth/{foo,bar}
  touch $Z_DATA

  for i in foo bar
    cd $pth/$i
  end
end

function teardown
  rm -rf $pth
end

test ".z is created"
  -f $Z_DATA
end

test "Z_CMD is set"
  ! -z $Z_CMD
end

test "has foo"
  0 -eq (grep -q foo $Z_DATA; echo $status)
end

test "has bar"
  0 -eq (grep -q bar $Z_DATA; echo $status)
end

test "! has kid"
  1 -eq (grep -q kid $Z_DATA; echo $status)
end

test "z --purge"
  -z (z --purge > /dev/null; cat $Z_DATA)
end

test "z --clean"
  1 -eq (echo '$pth/invalid_path|1|1501234567' >> $Z_DATA;
         z --clean > /dev/null;
         grep -q invalid_path $Z_DATA;
         echo $status)
end

test "z -e foo"
  $pth/foo = (z -e foo)
end

test "! z -e kid"
  (printf "'kid' did not match any results\n1") = (z -e kid; echo $status)
end

test "z -h"
  0 -eq (z -h | grep -q Usage; echo $status)
end

test "z foo"
  $pth/foo = (z foo; and echo $PWD)
end

test "z bar"
  $pth/bar = (z bar; and echo $PWD)
end

test "z kid"
  (printf "'kid' did not match any results\n1") = (z kid; and echo $PWD $status; or echo $status)
end

test "z --list foo"
  $pth/foo = (z --list foo ^/dev/null | awk '{ print $2} ')
end

test "list common path on stderr"
  "common:    $pth/foo" = (z --list foo 2>&1 >/dev/null | grep common:)
end

test "z -x works"
  (printf "'foo' did not match any results\n1") = (z foo; and z -x; and cd ..; and z foo; and echo $PWD $status; or echo $status;)
end
