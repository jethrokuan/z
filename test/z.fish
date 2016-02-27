set DIR $DIRNAME
set path $DIRNAME/$TESTNAME
set -g Z_DATA "$DIRNAME/.z"

debug "setting up"
echo > $Z_DATA
mkdir -p $path/{foo,bar,baz}

for i in foo bar baz
  cd $path/$i
end

function setup
  debug "setup test"
  set -g Z_DATA "$DIR/.z"
end

test "$Z_DATA is created"
  -f $Z_DATA
end

test "$Z_DATA has foo"
  "found it" = (cat "$Z_DATA" | grep -q foo; and echo "found it"; or echo "not found")
end

test "$Z_DATA has bar"
  "found it" = (cat "$Z_DATA" | grep -q bar; and echo "found it"; or echo "not found")
end

test "$Z_DATA does not have kid"
  "not found" = (cat "$Z_DATA" | grep -q kid; and echo "found it"; or echo "not found")
end

test "z -e does the right thing"
  $path/foo = (z -e foo)
end

test "z -h prints help"
  "found it" = (z -h | grep -q Usage; and echo "found it"; or echo "not found")
end

test "z -v shows not a valid option"
  "found it" = (z -v | grep -q valid; and echo "found it"; or echo "not found")
end

test "z foo does the right thing"
  $path/foo = (z foo; and echo $PWD)
end

test "z bar does the right thing"
  $path/bar = (z bar; and echo $PWD)
end

test "z kid returns no results"
  "'kid' did not match any results" = (z kid; and echo $PWD)
end


debug "tearing down"
rm -rf $path
