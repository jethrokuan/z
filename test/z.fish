set pth $DIRNAME/$TESTNAME
set -U Z_DATA "$pth/.z"
set -U Z_CMD  "j"

mkdir -p $pth/{foo,bar,baz}
touch $Z_DATA

for i in foo bar baz
  cd $pth/$i
end

function setup
  set -U Z_DATA "$pth/.z"
  set -U Z_CMD "j"
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

test "$Z_CMD -e foo"
  $pth/foo = (eval $Z_CMD -e foo)
end

test "$Z_CMD -e kid with correct exit code"
  "'kid' did not match any results1" = (eval $Z_CMD -e kid; echo $status)
end

test "$Z_CMD -h"
  "found it" = (eval $Z_CMD -h | grep -q Usage; and echo "found it"; or echo "not found")
end

test "$Z_CMD -v fails"
  "found it" = (eval $Z_CMD -v | grep -q valid; and echo "found it"; or echo "not found")
end

test "$Z_CMD foo"
  $pth/foo = (eval $Z_CMD foo; and echo $PWD)
end

test "$Z_CMD bar"
  $pth/bar = (eval $Z_CMD bar; and echo $PWD)
end

test "$Z_CMD kid"
  "'kid' did not match any results1" = (eval $Z_CMD kid; and echo $PWD $status; or echo $status)
end

rm -rf $pth
