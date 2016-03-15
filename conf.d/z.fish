if test -z "$Z_DATA"
  debug "Z_DATA not set, defaulting to $HOME/.z"
  set -U Z_DATA "$HOME/.z"
end

if test ! -f "$Z_DATA"
  debug "$Z_DATA not found, creating..."
  touch "$Z_DATA"
end

if test -z "$Z_CMD"
  debug "Z_CMD not set, defaulting to `z`"
  set -U Z_CMD "z"
end

set -U ZO_CMD ""

command printf "%so" $Z_CMD | read ZO_CMD

debug "$Z_CMD $ZO_CMD"

if test ! -z $Z_CMD
  function $Z_CMD -d "jump around"
    __z $argv
  end
end

if test ! -z $ZO_CMD
  function $ZO_CMD -d "open target dir" -a dir
    __z -o $dir
  end
end

if not set -q Z_EXCLUDE
  set -U Z_EXCLUDE $HOME
end  

function __z_on_variable_pwd --on-variable PWD
  __z_add
end
