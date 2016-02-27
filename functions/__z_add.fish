function __z_add -d "Add PATH to .z file" -a ZPATH
  if test $ZPATH = "$HOME" #Home directory is not worth monitoring
    return
  else
    set -l tmpfile (mktemp $Z_DATA.XXXXXX)
    if test -f $tmpfile
      set -l awk_prog '
      BEGIN {
        rank[path] = 1
        time[path] = now
        }
        $2 >= 1 {
        if( $1 == path ) {
          rank[$1] = $2 + 1
          time[$1] = now
          } 
        else {
          rank[$1] = $2
          time[$1] = $3
          }
          count += $2
          }
        END {
        if( count > 1000 ) {
          for( i in rank ) print i "|" 0.9*rank[i] "|" time[i] # aging
            }
          else for( i in rank ) print i "|" rank[i] "|" time[i]
            }
            '
            awk -v path="$ZPATH" -v now=(date +%s) -F "|" $awk_prog $Z_DATA ^ /dev/null > $tmpfile
            mv -f $tmpfile $Z_DATA
          end
          end
          __z_update_completions        
        end
