+++
date = "2017-09-24T16:06:00+02:00"
title = "Firejail"
tags = ["Containers", "Sandbox", "Security"]
+++

One big thing for me over the last few years is containers, security confinement and sandboxes. It's not a new thing, but in the Linux space a lot of interesting tooling around these technologies has appeared over the last years.

One of them are [Firejail](https://firejail.wordpress.com), it's a simple tool that can apply security constraints to an application. For example, I write this in the Markdown editor [Abricotine](https://github.com/brrd/Abricotine) now. All scary syscalls dropped, contained and in it's own network namespace with no network access. My home directory is also empty except the files I like to edit.

Firejail also arrives with a large list of profiles, for example one for Firefox and this is a good showcase example of when to use Firejail even for trusted applications. Your web browser is probably one of the most exposed pieces of software on your system.

Like to play a little? Install firejail and try these commands:

```shell
$ firejail xterm
```

A xterm window should open, it looks somewhat normal but try for example to run a few administrative commands that requires a little more permission:

```shell
$ ip a
Cannot open netlink socket: Operation not supported
$ mount
bash: /bin/mount: Permission denied
$ ls /sbin
ls: cannot open directory '/sbin': Permission denied
```

This is default permissions loaded from `/etc/firejail/default.profile`, if you like to disable the default profile append `--noprofile`.

Let's restrict this even more, let's hide more things in dev, empty etc and give me my own private tmp.

```shell
$ firejail --private-dev --private-etc=none --private-tmp xterm
```

Once again a xterm window, let's try a few things...

```shell
$ ls /etc
$ ls /tmp
$ touch /tmp/foo
$ ls /tmp
foo
$ ls /dev
dri  full  log  null  ptmx  pts  random  shm  snd  tty  urandom  zero
```

Fun, but we can still see files in my home directory, all my precious files.

```shell
$ firejail --private-dev --private-etc=none --private-tmp --private xterm
```

`--private` is the easiest option, all home folders are gone and you are inside a very private temporary home folder. Try to make a few files and poke around. Everything will be gone when we close the xterm window.

Of course in my Abricotine use case I need to be able to edit my blog's markdown files and they are hosted inside my home folder. For this use case we have the whitelist option.

```shell
$ firejail --private-dev --private-etc=none --private-tmp --whitelist=~/Downloads xterm
```

`--whitelist` can be defined multiple times listing the files I should have access to, everything else is gone. This can for example be combined with `--read-only` to expose a few directories read only to xterm.

With a tool this simple there is very little reason not to use it if you have to run a piece of software that you do not trust, or something that's exposed.