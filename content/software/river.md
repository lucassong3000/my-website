{:title "river"
 :slug "river"
 :type :markdown}
%%%
## Overview

River is a dynamic tiling Wayland compositor with flexible runtime
configuration. It is free and open source software.

River is [packaged](https://repology.org/project/river/versions) by various
Linux distributions as well as FreeBSD. The source code is hosted on
[codeberg](https://codeberg.org/river/river), which is where the issue tracker
may be found and where contributions are accepted. Read-only mirrors of the
source code exist on [sourcehut](https://git.sr.ht/~ifreund/river) and
[github](https://github.com/riverwm/river).

The current river release is [0.2.6](https://codeberg.org/river/river/releases/tag/v0.2.6).

River has not yet seen a stable 1.0 release and it will be necessary to make
significant breaking changes before 1.0 to realize my longer term goals. That
said, I do my best to avoid gratuitous breaking changes and bugs/crashes should
be rare. If you find a bug don't hesitate to [open an
issue](https://codeberg.org/river/river/issues/new/choose).

## Features

Currently river's window management style is quite similar to
[dwm](http://dwm.suckless.org), [xmonad](https://xmonad.org), and other classic
dynamic tiling X11 window managers. Windows are automatically arranged in a tiled
layout and shifted around as windows are opened/closed.

Rather than having the tiled layout logic built into the compositor process,
river uses a [custom Wayland
protocol](https://codeberg.org/river/river/src/branch/master/protocol/river-layout-v3.xml)
and separate "layout generator" process. A basic layout generator, `rivertile`,
is provided but users are encouraged to other community-developed [layout
generators](https://codeberg.org/river/wiki/src/branch/master/pages/Community-Layouts.md)
or write their own. Examples in C and Python may be found
[here](https://codeberg.org/river/river/src/branch/master/contrib).

Tags are used to organize windows rather than workspaces. A window may be
assigned to one or more tags. Likewise, one or more tags may be displayed on a
monitor at a time.

River is configured at runtime using the `riverctl` tool. It can define
keybindings, set the active layout generator, configure input devices, and more.
On startup, river runs a user-defined init script which usually runs `riverctl`
commands to set up the user's configuration.

## Documentation

The offical river documentation is the [man pages](https://codeberg.org/river/river/src/branch/master/doc).
We also have a [wiki](https://codeberg.org/river/wiki).

To discuss river and ask questions, join our IRC channel,
[#river](https://web.libera.chat/?channels=#river) on irc.libera.chat. Our code
of conduct may be found
[here](https://codeberg.org/river/river/src/branch/master/CODE_OF_CONDUCT.md)

## Future Plans

Currently details such as how tags work across mulitple monitors are not
possible for users to configure. It would be possible to extend river's source
code to allow more flexibility here but this comes at the cost of complexity and
there will always be someone who prefers something slightly different.

My long term plan to address this is to move as much window management policy as
possible out of the river compositor process and into the "layout generator"
process which will need to be renamed to "window manager." This will give users
much more power and control over river's behavior and also enable some really
cool workflows. For example, it would be possible to write a window manager in
lisp and use hot code reloading to edit its behavior it while it is running.

This is a non-trivial architectural change and will take a while to implement. I
plan to focus on this change for the 0.4.0 release cycle. Unfortunately, it will
almost certainly break existing river configurations as well. I think the
benefits outweigh that downside though and I will do my best to offer a
reasonable upgrade path.
