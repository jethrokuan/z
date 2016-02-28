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

test "z --clean"
  -z (z --clean > /dev/null; cat $Z_DATA)
end

test "z -e foo"
  $pth/foo = (z -e foo)
end

test "! z -e kid"
  "'kid' did not match any results1" = (z -e kid; echo $status)
end

test "z -h"
  0 -eq (z -h | grep -q Usage; echo $status)
end

test "z -v fails"
  0 -eq (z -v | grep -q valid; echo $status)
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
