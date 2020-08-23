z(1) -- jump around
=================================
## Name

z - jump around: port of rupa's z

## SYNOPSIS

`z [-cehlprt] string1 string2...` <br>
`zo [-cehlprt] string1 string2...`

## DESCRIPTION

Port of rupa's z:

Tracks your most used directories, based on 'frecency'. The data is
stored in a file located at `$Z_DATA`.

After a short learning phase, z will take you to the most 'frecent'
directory that matches ALL of the strings given on the command line,
in order.

For more details about frecency, see https://github.com/rupa/z.

## OPTIONS
  * `-c`, `--clean`:
    Removes directories that no longer exist from `$Z_DATA`.

  * `-e`, `--echo`:
    Prints the best match. No cd.

  * `-h`, `--help`:
    Show a brief help message.

  * `-l`, `--list`:
    Show a list of matches, and their scores. No cd.

  * `-r`, `--rank`:
    Match by rank only.

  * `-t`, `--recent`:
    Match by recent only.

  * `-x`, `--delete`:
    Removes the current directory from `$Z_DATA`.

## EXAMPLES

  * `z foo`:
    Goes to directory best matching `foo`.

  * `zo foo`:
    Opens file manager of directory best matching `foo`.

  * `z -t foo`:
    Goes to most recent directory matching `foo`.

  * `z -x`:
    Removes the current directory from `$Z_DATA`.

## CONFIGURATION

  * `set -U Z_CMD "j"`:
    Change commands to `j` and `jo`

  * `set -U Z_DATA "$HOME/.foo"`:
    Set data file to `$HOME/.foo`

  * `set -U ZO_METHOD "opencmd"`:
    Runs `opencmd dir` on `zo dir` (defaults to `open` or `xdg-open`)

  * `set -U Z_OWNER "username"`:
    Ensure data file is owned by `username`. This prevents usage of `z`
    with `sudo` to cause file to be inaccessible in non-sudo sessions.

  * `set -p Z_EXCLUDE "regex"`:
    Exclude all directories matching the regex from being added to the 
    z-store in the future. This does not modify the existing store.
    
    For example `set -p Z_EXCLUDE "^/mnt/workVPN"` will block all paths starting
    with `/mnt/workVPN`. `set -P Z_EXCLUDE "^/mnt/workVPN\$"` would exclude
    exactly that directory, but not any of `/mnt/workVPN`'s subdirectories.
