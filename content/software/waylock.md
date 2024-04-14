{:title "waylock"
 :slug "waylock"
 :type :markdown}
%%%
## Overview

Waylock is a small screenlocker for Wayland compositors implementing the
<span class="nowrap">ext-session-lock-v1</span> protocol.
It is free and open source software.

Waylock is [packaged](https://repology.org/project/waylock/versions) by various
Linux distributions as well as FreeBSD. The source code is hosted on
[codeberg](https://codeberg.org/ifreund/waylock), which is where the issue tracker
may be found and where contributions are accepted. Read-only mirrors of the
source code exist on [sourcehut](https://git.sr.ht/~ifreund/waylock) and
[github](https://github.com/ifreund/waylock).

## Features

Waylock's feature set prioritizes functionality and simplicity. When the session
is locked, all monitors are blanked with a solid color. Keyboard input will
cause the color to change. If the password is incorrect, the color will turn
red, if correct the session will be unlocked. The colors are configurable with
command line options but that's about it, see the
[waylock(1)](https://codeberg.org/ifreund/waylock/src/branch/master/doc/waylock.1.scd)
man page for details.

Waylock supports readiness notification for race-free lock and suspend by either
forking to the background or writing to a user-provided file descriptor after
the session has been locked. See the
[waylock(1)](https://codeberg.org/ifreund/waylock/src/branch/master/doc/waylock.1.scd)
man page for details.

## ext-session-lock-v1

The [ext-session-lock-v1](https://gitlab.freedesktop.org/wayland/wayland-protocols/-/blob/main/staging/ext-session-lock/ext-session-lock-v1.xml)
protocol is a Wayland protocol extension I developed. It is included in the official
[wayland-protocols](https://gitlab.freedesktop.org/wayland/wayland-protocols)
repository.

This protocol is significantly more robust than previous client-side Wayland
screen locking approaches. Importantly, the screenlocker crashing does not cause
the session to be unlocked.

The ext-session-lock-v1 protocol is supported by many Wayland compositors
including [river](/software/river/), [sway](swaywm.org),
[Wayfire](https://wayfire.org), [labwc](https://github.com/labwc/labwc/),
[Mir](https://github.com/canonical/mir), and more.
