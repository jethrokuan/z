[![Build Status][travis-badge]][travis-link]
[![Slack Room][slack-badge]][slack-link]

# Z

**z** is a fork of @rupa's [z](http://github.com/rupa/z). This is based off @sjl's [port to fish](https://github.com/sjl/z-fish), updated after its discontinued support.

## Install

With [Fisherman]

```
fisher install jethrokuan/fish-z
```

## Usage
``` fish
z [-e --echo]     Echo best match without changing directory
z [-l --list]     List matches without changing directory
z [-r --rank]     Searches and changes directory by rank
z [-t --recent]   Search and changes directory by recency
z [ -h --help]    Print this help
```

[slack-link]: https://fisherman-wharf.herokuapp.com/
[slack-badge]: https://img.shields.io/badge/slack-join%20the%20chat-00B9FF.svg?style=flat-square
[Fisherman]: https://github.com/fisherman/fisherman
[travis-link]: https://travis-ci.org/jethrokuan/fish-z
[travis-badge]: https://img.shields.io/travis/jethrokuan/fish-z.svg?style=flat-square
