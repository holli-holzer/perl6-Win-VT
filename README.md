NAME
====

	Win::VT - Virtual terminal support for Windows

SYNOPSIS
========

    use Win::VT;

    # enable escape sequences
    # only for output
    vt-on( :vt-input(False) );

	# enable escape sequences
    # only for input
    vt-on( :vt-output(False) );

	# enable escape sequences
	# for both
    vt-on;

	# clear screen
	say chr(27) ~ '[2J' ~ chr(27) ~ '[;H';

	# disable escape sequences again
	vt-off;

	# Or short
	use Win::VT :cls;
    cls;

DESCRIPTION
===========

The Windows™ console has made great progress over the years regarding its support for terminal emulation. These
capabilities are disabled by default. Using this module you can easily enable and disable them.

You should make sure to always disable the input emulation cleanly when your program exits, or your shell will be messed up.

The main module provides the `vt-on` and `vt-off` functions that lets you control things manually.

`Win::VT::Auto` provides additional sugar. It will automatically enable VT at `INIT` time and disable at `END` time.
It also catches `SIGINT` for you and disables VT in case of a crash or user interruption.

Using `Win::VT::Auto` the "clear screen" example from above can written as:

    ~$ perl6 -MWin::VT::Auto -e "say chr(27) ~ '[2J' ~ chr(27) ~ '[;H';"

Or even

    ~$ perl6 -MWin::VT::Auto::O -e "say chr(27) ~ '[2J' ~ chr(27) ~ '[;H';"

The "O" in `Win::VT::Auto::O` stands for Output (only) obviously. Analogous there is `Win::VT::Auto::I`.

AUTHOR
======

    Markus «Holli» Holzer

COPYRIGHT AND LICENSE
=====================

Copyright © Markus Holzer ( holli.holzer@gmail.com )

License <GPLv3|: [The GNU General Public License](https://www.gnu.org/licenses/gpl-3.0.txt), Version 3, 29 June 2007

This is free software: you are free to change and redistribute it. There is NO WARRANTY, to the extent permitted by law.