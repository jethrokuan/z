set -xg pth (mktemp -d)

set -xg Z_DATA "$pth/.z"
mkdir -p $pth/{foo,bar}
# we can't have | because it is the separator in $Z_DATA
set -xg special '(){}#$%^<>?*"\'\\ &	'
mkdir -p $pth/{foo,bar,$special}
touch $Z_DATA

function cd_some
    z --clean
    for i in foo bar $special
        cd $pth/$i
    end
end

cd_some

echo pth $pth >&2
echo Z_DATA $Z_DATA >&2
@test ".z is created" -f $Z_DATA

@test "Z_CMD is set" ! -z $Z_CMD

@test "has foo" 0 -eq (grep -q foo $Z_DATA; echo $status)

@test "has bar" 0 -eq (grep -q bar $Z_DATA; echo $status)

@test "has special" 0 -eq (fish -c 'grep -qF $special $Z_DATA'; echo $status)

@test "! has kid" 1 -eq (grep -q kid $Z_DATA; echo $status)

@test "z --purge" -z (z --purge > /dev/null; cat $Z_DATA)

@test "z --clean" 1 -eq (
        echo '$pth/invalid_path|1|1501234567' >> $Z_DATA;
        z --clean > /dev/null;
        grep -q invalid_path $Z_DATA;
        echo $status
     )
cd_some

@test "z -e foo" $pth/foo = (z -e foo)

@test "! z -e kid" 1 = (z -e kid >/dev/null; echo $status)

@test "z -h" 0 -eq (z -h | grep -q Usage; echo $status)

@test "z foo" $pth/foo = (z foo; and echo $PWD)

@test "z bar" $pth/bar = (z bar; and echo $PWD)

@test "f oo" $pth/foo = (z f oo; and echo $PWD)

@test "fo oo" $pth/foo != (z fo oo; and echo $PWD)

@test "z kid" 1 = (z kid >/dev/null; echo $status)

@test "z special" 0 -eq (fish -c 'z $special' >/dev/null; echo $status)

@test "z --list foo" $pth/foo = (z --list foo 2>/dev/null | awk '{ print $2} ')

@test "z -x works" 1 = (begin; z foo; and z -x; and cd ..; and z foo; end >/dev/null; echo $status)

rm -rf $pth
