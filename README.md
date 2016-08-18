# nocolor

Sometime the live is dark.

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
hello

Memory usage summary: heap total: 27223, heap peak: 22559, stack peak: 2752
         total calls   total memory   failed calls
 malloc|          0              0              0
realloc|        298          27223              0  (nomove:5, dec:3, free:0)
 calloc|          0              0              0
   free|        316          27111
Histogram for block sizes:
   16-31            154  51% ==================================================
   32-47             69  23% ======================
   48-63             10   3% ===
   64-79             22   7% =======
   80-95              9   3% ==
  128-143             1  <1% 
  144-159             1  <1% 
  160-175             5   1% =
  208-223             1  <1% 
  256-271             1  <1% 
  320-335             7   2% ==
  512-527             1  <1% 
  608-623             1  <1% 
  640-655            10   3% ===
  704-719             1  <1% 
 1024-1039            1  <1% 
 1280-1295            2  <1% 
 2048-2063            1  <1% 
 2560-2575            1  <1% 
```

The color sequence was removed in this sample.
See the `samples/memusage-with-color.txt` file for a real colored sample.

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

