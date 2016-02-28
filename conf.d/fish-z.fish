if not set -U -q Z_DATA
  debug "Z_DATA not set, defaulting to $HOME/.z"
  set -U Z_DATA "$HOME/.z"
end

if test ! -f "$Z_DATA"
  debug "$Z_DATA not found, creating..."
  touch "$Z_DATA"
end

if not set -U -q Z_CMD
  debug "Z_CMD not set, defaulting to `z`"
  set -U Z_CMD "z"
end

function $Z_CMD -d "jump around"
  __z $argv
end

function __z_monitor --on-variable PWD
  __z_add "$PWD"
end
