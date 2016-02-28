[![Build Status][travis-badge]][travis-link]
[![Slack Room][slack-badge]][slack-link]

# Z

**z** is the new [z](http://github.com/rupa/z).

z uses a combination of recency and frequency (termed _frecency) to bring you to the directory you want.

## Install

With [Fisherman]

```
fisher install z
```

## Usage
``` fish
z [-c --clean]    Cleans out Z_DATA
z [-e --echo]     Prints best match, no cd
z [-l --list]     List matches, no cd
z [-r --rank]     Searches by rank, cd
z [-t --recent]   Searches by recency, cd
z [ -h --help]    Print this help
```

## Examples
``` fish
z foo             Goes to directory best matching foo
z -t foo          Goes to most recent directory matching foo
```

## License
MIT

[slack-link]: https://fisherman-wharf.herokuapp.com/
[slack-badge]: https://img.shields.io/badge/slack-join%20the%20chat-00B9FF.svg?style=flat-square
[Fisherman]: https://github.com/fisherman/fisherman
[travis-link]: https://travis-ci.org/fishery/fish-z
[travis-badge]: https://img.shields.io/travis/fishery/fish-z.svg?style=flat-square

