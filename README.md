[![Build Status][travis-badge]][travis-link]
[![Slack Room][slack-badge]][slack-link]

# Z

**z** is a fish port of [z](http://github.com/rupa/z).

**z** tracks the directories you visit. With a combination of frequency and recency, it enables you to jump to the directory in mind.

A _pure-fish_ port means it is _fast_ and _fish-friendly_, with tab-completions and lazy-loading. Top that off with greater customizability and a small amount of added functionality.

## Install
> Note: fish version >2.2.0 is required.

### fish >=2.3.0
With [fisherman]

```
fisher z
```

### fish <2.3.0
If you can't upgrade your build, append the following code to your `~/.config/fish/config.fish`.

```fish
for file in ~/.config/fish/conf.d/*.fish
    source $file
end
```

Or let me do that for you.

```fish
curl -L git.io/v6kNP >> ~/.config/fish/config.fish
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
set -U ZO_METHOD "opencmd"     Runs `opencmd dir` on `zo dir` (defaults to `open` or `xdg-open`)
```

[slack-link]: https://fisherman-wharf.herokuapp.com
[slack-badge]: https://fisherman-wharf.herokuapp.com/badge.svg

[travis-link]: https://travis-ci.org/fisherman/z
[travis-badge]: https://travis-ci.org/fisherman/z.svg?branch=master

[fisherman]: https://github.com/fisherman/fisherman

<!-- Local Variables: -->
<!-- firestarter-type: t -->
<!-- firestarter: "ronn %f;and mv %s man/man1/z.1" -->
<!-- End: -->
