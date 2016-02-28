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
  "found it" = (cat "$Z_DATA" | grep -q foo; and echo "found it"; or echo "not found")
end

test "has bar"
  "found it" = (cat "$Z_DATA" | grep -q bar; and echo "found it"; or echo "not found")
end

test "does not have kid with correct exit code"
  "not found 1" = (cat "$Z_DATA" | grep -q kid; and echo "found it" $status; or echo "not found" $status;)
end

test "z -e foo"
  $pth/foo = (z -e foo)
end

test "z -e kid with correct exit code"
  "'kid' did not match any results1" = (z -e kid; echo $status)
end

test "z -h"
  "found it" = (z -h | grep -q Usage; and echo "found it"; or echo "not found")
end

test "z -v fails"
  "found it" = (z -v | grep -q valid; and echo "found it"; or echo "not found")
end

test "z foo"
  $pth/foo = (z foo; and echo $PWD)
end

test "z bar"
  $pth/bar = (z bar; and echo $PWD)
end

test "z kid"
  "'kid' did not match any results1" = (z kid; and echo $PWD $status; or echo $status)
end
