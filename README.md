[![Build Status][travis-badge]][travis-link]
[![Slack Room][slack-badge]][slack-link]

# Z

**z** is the new [z](http://github.com/rupa/z).

z uses a combination of recency and frequency (termed _frecency_) to bring you to the directory you want.

Recommended fish version: `2.2.0`

## Install

With [fisherman]

```
fisher z
```

## Notes

`z` was built for the latest fish, but at least 2.2.0 is required. If you can't upgrade your build, append the following code to your `~/.config/fish/config.fish`.

```fish
for file in ~/.config/fish/conf.d/*.fish
    source $file
end
```

Or let me do that for you.

```fish
curl -L git.io/confd >> ~/.config/fish/config.fish
```

## Usage
```
z [-c --clean]       Cleans out Z_DATA
z [-e --echo] foo    Prints best match, no cd
z [-l --list] foo    List matches, no cd
z [-r --rank] foo    Searches by rank, cd
z [-t --recent] foo  Searches by recency, cd
z [ -h --help]       Print this help
zo foo               Opens file manager for best match
```

## Examples
``` 
z foo             Goes to directory best matching foo
zo foo            Opens file manager of directory best matching foo
z -t foo          Goes to most recent directory matching foo
```

## Configuring Z
There are commands that let you modify the behaviour of `z`:
```fish
set -U Z_CMD "j"               Change commands to j and jo
set -U Z_DATA "$HOME/.foo"     Set data file to $HOME/.foo
set -U ZO_METHOD "opencmd"     Runs `opencmd dir` on `zo dir`
```

[slack-link]: https://fisherman-wharf.herokuapp.com/
[slack-badge]: https://img.shields.io/badge/slack-join%20the%20chat-00B9FF.svg?style=flat-square
[fisherman]: https://github.com/fisherman/fisherman
[travis-link]: https://travis-ci.org/fisherman/z
[travis-badge]: https://img.shields.io/travis/fisherman/z.svg?style=flat-square
[fin]:https://github.com/fisherman/fin

<!-- Local Variables: -->
<!-- firestarter-type: t -->
<!-- firestarter: "ronn %f;and mv %s man/man1/z.1" -->
<!-- End: -->
