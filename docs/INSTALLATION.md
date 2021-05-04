# Installation

You need [Vim](http://www.vim.org) to do the exercises:

- [macOS](#macos)
- [Ubuntu / Debian](#ubuntu--debian)
- [Windows](#windows)
- [Source](#source)

## macOS

The OS ships with Vim by default, but it's a hopelessly outdated version.

Chances are you're either using [MacPorts](https://www.macports.org) or
[Homebrew](https://brew.sh) to install software.

Homebrew:

```
$ brew update
$ brew install vim
```

MacPorts:

```
$ sudo port install vim +huge
```

If you want a GUI, have a look at [MacVim](https://macvim-dev.github.io/macvim)
instead.

## Ubuntu / Debian

Install a full-fledged Vim with GUI support (`gvim`):

```
$ sudo apt-get update
$ sudo apt-get install vim-gtk
```

## Windows

Using [Chocolatey](https://chocolatey.org):

```
C:\> choco install vim
```

Or download and install directly from [here](http://www.vim.org/download.php#pc).

## Source

If you want to compile the latest Vim yourself, check out the [official
repository on GitHub](https://github.com/vim/vim).
