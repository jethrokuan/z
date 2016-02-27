set pth $DIRNAME/$TESTNAME
set -g Z_DATA "$pth/.z"

mkdir -p $pth/{foo,bar,baz}
touch $Z_DATA

for i in foo bar baz
  cd $pth/$i
end

function setup
  set -g Z_DATA "$pth/.z"
end

test ".z is created"
  -f $Z_DATA
end

test "has foo"
  "found it" = (cat "$Z_DATA" | grep -q foo; and echo "found it"; or echo "not found")
end

test "has bar"
  "found it" = (cat "$Z_DATA" | grep -q bar; and echo "found it"; or echo "not found")
end

test "does not have kid"
  "not found" = (cat "$Z_DATA" | grep -q kid; and echo "found it"; or echo "not found")
end

test "z -e foo"
  $pth/foo = (z -e foo)
end

test "z -e kid"
  "'kid' did not match any results" = (z -e kid)
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
  "'kid' did not match any results" = (z kid; and echo $PWD)
end

rm -rf $pth
