# nocolor

`Rose, La vie n'est pas toujours rose ! ;oP`

Introduction
============

Usual case
----------

Usually shell command detects and disable color when the content is piped.
But sometime you can not got the result without color

```sh
$ ls -l --color=auto                          # result with    color
$ ls -l --color=auto > ls.txt                 # result without color
```
```sh
$ echo abc | grep --color=auto b              # with    color
# echo abc | grep --color=auto b > grep.txt   # without color
```


Some case with unwanted color
-----------------------------

I was studing memory allocation behavior of lua.

```
$ memusage lua -e 'print("hello")'
or
$ LD_PRELOAD="$(find /lib -name libmemusage.so)" lua -e 'print("hello")'
```

See the [samples/memusage-with-color.txt](samples/memusage-with-color.txt) file for a real colored sample.


How to remove ansi color sequence
---------------------------------

The ansi color sequence to filter is something like `0x1b` + `[` + (<number> or `;`) + `m`
I discovered grep use a reset sequence like `0x1b` + `[` + `K`. I also filter it.

I made solution with :
 * shell (with sed)
 * lua

How to use
==========

Shell
-----

```sh
$ ls -l --color=always | /path/to/nocolor.sh
$ echo abc | grep --color=always b | /path/to/nocolor.sh
```

Lua
---

```sh
$ ls -l --color=always | /path/to/nocolor.lua
$ echo abc | grep --color=always b | /path/to/nocolor.lua
```

Shell env
---------

```sh
$ . ./nocolor.sh
$ ls -l --color=always | nocolor
$ echo abc | grep --color=always b | nocolor
```

Screenshot
==========

![sample screenshot with and without color](samples/sample.png?raw=true "Sample screenshot with and without color")

