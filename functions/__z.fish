function __z -d "Jump to a recent directory."
    function __print_help -d "Print z help."
        printf "Usage: $Z_CMD  [-celrth] regex1 regex2...\n\n"
        printf "         -c --clean    Removes directories that no longer exist from $Z_DATA\n"
        printf "         -d --dir      Opens matching directory using system file manager.\n"
        printf "         -e --echo     Prints best match, no cd\n"
        printf "         -l --list     List matches and scores, no cd\n"
        printf "         -p --purge    Delete all entries from $Z_DATA\n"
        printf "         -r --rank     Search by rank\n"
        printf "         -t --recent   Search by recency\n"
        printf "         -x --delete   Removes the current directory from $Z_DATA\n"
        printf "         -h --help     Print this help\n\n"

        if type -q fisher
            printf "Run `fisher help z` for more information."
        end
    end

    set -l options "h/help" "c/clean" "e/echo" "l/list" "p/purge" "r/rank" "t/recent" "d/directory" "x/delete"
    set -g z_path (command dirname (status -f))

    argparse $options -- $argv

    if set -q _flag_help
        __print_help
        return 0
    else if set -q _flag_clean
        __z_clean
        printf "%s cleaned!" $Z_DATA
        return 0
    else if set -q _flag_purge
        echo > $Z_DATA
        printf "%s purged!" $Z_DATA
        return 0
    else if set -q _flag_delete
        sed -i -e "\:^$PWD|.*:d" $Z_DATA
        return 0
    end

    set -l typ

    if set -q _flag_rank
        set typ "rank"
    else if set -q _flag_recent
        set typ "recent"
    end

    if set -q _flag_list
        # Handle list separately as it can print common path information to stderr
        # which cannot be captured from a subcommand.
        command awk -v t=(date +%s) -v list="list" -v typ="$typ" -v q="$argv" -F "|" -f $z_path/z.awk "$Z_DATA"
    else
        set target (command awk -v t=(date +%s) -v typ="$typ" -v q="$argv" -F "|" -f $z_path/z.awk "$Z_DATA")

        if test "$status" -gt 0
            return
        end

        if test -z "$target"
            printf "'%s' did not match any results" "$argv"
            return 1
        end

        if set -q _flag_list
            echo "$target" | tr ";" "\n" | sort -nr
            return 0
        end

        if set -q _flag_echo
            printf "%s\n" "$target"
        else if set -q _flag_directory
            type -q xdg-open;and xdg-open "$target"; and return $status;
            type -q open;and open "$target"; and return $status;
            echo "Not sure how to open file manager"; and return 1;
        else
            pushd "$target"
        end
    end
end
