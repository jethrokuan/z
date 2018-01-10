function frecent(rank, time) {
    dx = t-time
    if( dx < 3600 ) return rank*4
    if( dx < 86400 ) return rank*2
    if( dx < 604800 ) return rank/2
    return rank/4
}

function output(files, toopen) {
    if( option == "list" ) {
        for( i in files ) if( files[i] ) printf "%-10s %s;", files[i], i
    } else {
        print toopen
    }
}

function common(matches, fnd, nc) {
    for( i in matches ) {
        if( matches[i] && (!short || length(i) < length(short)) ) short = i
    }
    if( short == "/" ) return
    for( i in matches ) if( matches[i] && i !~ short ) x = 1
    if( x ) return
    if( nc ) {
        for( i in fnd ) if( tolower(short) !~ tolower(fnd[i]) ) x = 1
    } else for( i in fnd ) if( short !~ fnd[i] ) x = 1
    if( !x ) return short
}

BEGIN { split(q, a, " ") }
    {
        if( system("test -d \"" $1 "\"") ) next
        if( typ == "rank" ) {
            f = $2
        } else if( typ == "recent" ) {
            f = t-$3
        } else f = frecent($2, $3)
        wcase[$1] = nocase[$1] = f
        for( i in a ) {
            if( $1 !~ a[i] ) delete wcase[$1]
            if( tolower($1) !~ tolower(a[i]) ) delete nocase[$1]
        }
        if( wcase[$1] > oldf ) {
            cx = $1
            oldf = wcase[$1]
        } else if( nocase[$1] > noldf ) {
            ncx = $1
            noldf = nocase[$1]
        }
    }
    END {
        if( cx ) {
            output(wcase, cx)
        } else if( ncx ) output(nocase, ncx)
    }
