set -l path $DIRNAME/$TESTNAME

function -S setup
  set -U Z_DATA "$path/.z"
  set -U Z_EXCLUDE "$path/gen" "$path/vim"
  mkdir -p $path/{foo,bar,gen,vim}

  touch $Z_DATA

  for i in foo bar gen vim
    cd $path/$i
  end
end

function -S teardown
  rm -rf $path
end

test "! has gen"
  1 -eq (grep -q gen $Z_DATA; echo $status)
end

test "! has vim"
  1 -eq (grep -q vim $Z_DATA; echo $status)
end
