[![Build Status][travis-badge]][travis-link]
[![Slack Room][slack-badge]][slack-link]

# Z

**z** is the new [z](http://github.com/rupa/z).

z uses a combination of recency and frequency (termed _frecency_) to bring you to the directory you want.

Recommended fish version: `2.2.0`

## Install

With [Fisherman]

```
fisher install z
```

With [fin]

```
fin z
```

_NOTE: `z` requires `conf.d` support, so if you're installing `z` with fish `<2.3.0` you'll need to add the following snippet in `.config/fish/config.fish` to support that:_

```
for file in ~/.config/fish/conf.d/*.fish
    source $file
end
```

## Usage
``` fish
z [-c --clean]       Cleans out Z_DATA
z [-e --echo] foo    Prints best match, no cd
z [-l --list] foo    List matches, no cd
z [-r --rank] foo    Searches by rank, cd
z [-t --recent] foo  Searches by recency, cd
z [ -h --help]       Print this help
zo foo               Opens file manager for best match
```

## Examples
``` fish
z foo             Goes to directory best matching foo
zo foo            Opens file manager of directory best matching foo
z -t foo          Goes to most recent directory matching foo
```

## Configuring Z
There are commands that let you modify the behaviour of `z`:
``` fish
set -U Z_CMD "j"               Change commands to j and jo
set -U Z_DATA "$HOME/.foo"     Set data file to $HOME/.foo
set -U ZO_METHOD "opencmd"     Runs `opencmd dir` on `zo dir`
```

## License
The MIT License (MIT)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

[slack-link]: https://fisherman-wharf.herokuapp.com/
[slack-badge]: https://img.shields.io/badge/slack-join%20the%20chat-00B9FF.svg?style=flat-square
[Fisherman]: https://github.com/fisherman/fisherman
[travis-link]: https://travis-ci.org/fisherman/z
[travis-badge]: https://img.shields.io/travis/fisherman/z.svg?style=flat-square
[fin]:https://github.com/fisherman/fin

<!-- Local Variables: -->
<!-- firestarter-type: t -->
<!-- firestarter: "ronn %f;and mv %s man/man1/z.1" -->
<!-- End: -->
