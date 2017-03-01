# gpmx.dart 
[![Build Status](https://travis-ci.org/axetroy/gpm.svg?branch=master)](https://travis-ci.org/axetroy/gpm)
![License](https://img.shields.io/badge/license-MIT-green.svg)
![Node](https://img.shields.io/badge/dart-%3E=1.2.0-blue.svg?style=flat-square)



Git Package Manager, make you manage the repository easier

## Features

- [x] support Github, Gitlab, etc
- [x] add, remove, clean, cache, list commands
- [x] score, humanize, easier to manager
- [ ] add repository in multi directories

## Installation

// TODO

## Requirement

- dart

## Supports

- [ ] Windows
- [x] Linux
- [x] MacOS

## Usage

```bash
gpmx -h

# print out

Git Package Manager, make you manage the repository easier.

Usage: gpmx <command> [arguments]

Global options:
-h, --help    Print this usage information.

Available commands:
  add       clone repo into local dir.
  clean     clean the temp/cache.
  help      Display help information for gpmx.
  list      display the all repo.
  remove    remove a repo.
  runtime   print the program runtime, useful for submit a issue.

Run "gpmx help <command>" for more information about a command.

```

### Config

this is a default config, it will be generated in ``~/.gpmx`` by default

```json
{
  "name": "gpmx",
  "base": "gpmx"
}
```

- name: user name
- base: the repositories base dir, all repository will be install in this dir

## Example

```bash
gpmx add https://github.com/zeit/release.git
gpmx add https://github.com/axetroy/gpm.git
gpmx add https://github.com/axetroy/ymli.git

gpmx ls

# print out
github.com: 
  axetroy: 
    gpm:  /home/axetroy/gpmx/github.com/axetroy/gpm
    ymli: /home/axetroy/gpmx/github.com/axetroy/ymli
  zeit: 
    release: /home/axetroy/gpmx/github.com/zeit/release
```

## Uninstall

// TODO

## Contribute

```bash
git clone https://github.com/axetroy/gpm.dart.git
cd ./gpm.dart
pub get
dart ./bin/gpmx
```

You can flow [Contribute Guide](https://github.com/axetroy/gpm/blob/master/contributing.md)

## License

The [MIT License](https://github.com/axetroy/gpm/blob/master/LICENSE)
