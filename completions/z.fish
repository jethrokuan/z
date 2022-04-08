  complete -c z -a "(z -l | string replace -r '^\\S*\\s*' '')" -f -k

  complete -c z -s c -l clean -d "Cleans out $Z_DATA"
  complete -c z -s e -l echo -d "Prints best match, no cd"
  complete -c z -s l -l list -d "List matches, no cd"
  complete -c z -s p -l purge -d "Purges $Z_DATA"
  complete -c z -s r -l rank -d "Searches by rank, cd"
  complete -c z -s t -l recent -d "Searches by recency, cd"
  complete -c z -s h -l help -d "Print help"
  complete -c z -s x -l delete -d "Removes the current directory from $Z_DATA"
