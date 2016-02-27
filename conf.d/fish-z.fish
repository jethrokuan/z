set -gx Z_DATA "$HOME/.z"

if test ! -f "$Z_DATA"
  debug "$Z_DATA not found, creating..."
  touch "$Z_DATA"
end

function __z_monitor --on-variable PWD
  __z_add "$PWD"
end
