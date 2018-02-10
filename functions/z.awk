function frecent(rank, time) {
    dx = t-time
    if( dx < 3600 ) return rank*4
    if( dx < 86400 ) return rank*2
    if( dx < 604800 ) return rank/2
    return rank/4
}

function output(matches, best_match, common) {
    # list or return the desired directory
    if( list ) {
        cmd = "sort -nr"
        for( x in matches ) {
            if( matches[x] ) {
                printf "%-10s %s\n", matches[x], x | cmd
            }
        }
        if( common ) {
            printf "%-10s %s\n", "common:", common > "/dev/stderr"
        }
    } else {
        if( common ) best_match = common
        print best_match
    }
}

function common(matches) {
    # find the common root of a list of matches, if it exists
    for( x in matches ) {
        if( matches[x] && (!short || length(x) < length(short)) ) {
            short = x
        }
    }
    if( short == "/" ) return
    for( x in matches ) if( matches[x] && index(x, short) != 1 ) {
            return
        }
    return short
}

BEGIN {
    gsub(" ", ".*", q)
    hi_rank = ihi_rank = -9999999999
}
{
    if( typ == "rank" ) {
        rank = $2
    } else if( typ == "recent" ) {
        rank = $3 - t
    } else rank = frecent($2, $3)
    if( $1 ~ q ) {
        matches[$1] = rank
    } else if( tolower($1) ~ tolower(q) ) imatches[$1] = rank
    if( matches[$1] && matches[$1] > hi_rank ) {
        best_match = $1
        hi_rank = matches[$1]
    } else if( imatches[$1] && imatches[$1] > ihi_rank ) {
        ibest_match = $1
        ihi_rank = imatches[$1]
    }
}

END {
# prefer case sensitive
    if( best_match ) {
        output(matches, best_match, common(matches))
    } else if( ibest_match ) {
        output(imatches, ibest_match, common(imatches))
    }
}
