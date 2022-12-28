+++
date = "2017-12-14T14:45:00+01:00"
title = "Snapcraft"
[taxonomies]
tags = ["snaps", "snapcraft", "packages"]
+++

One of the things I always liked with Ubuntu it is "A better Debian Unstable". Same package format and OS layout. A reasonable mix between new packages, and stability and QA.

I have been using Debian, Ubuntu, Linux Mint, Ubuntu Mate, Elementary OS, Ubuntu Budgie and Ubuntu GNOME now for over a decade as my main distros and there is a reason for that, deb packages and the ecosystem.

I'm known to be a little cranky when things changes, so the first time I heard about the new package format "snap" my first reaction was negative. I did not like the idea that Ubuntu was going to replace deb package format, because this was one of the main reasons I had stayed with Ubuntu for over a decade. Since then, I have started to poke around in the snaps ecosystem and I'm not that worried. Support for classic deb packages will be around for a long time, and snaps are not that bad, actually they are awesome.

## What is snap / snapd / snappy / snapcraft?

The packages are called snap with the extension `.snap`, snappy is a nickname given the entire project by developers and people involved in the project. They also use "snap that" as a verb. snapd is the "snap daemon", a system service that runs on your system to manage the packages. Finally snapcraft is the build tool that creates the snap packages, and this is also the most used official term to describe the entire thing, for example the domain is [snapcraft.io](https://snapcraft.io)

### Why not debs?

The deb format, and most other packages format from that era like rpm are just glorified tar-balls (bundles of files) with some metadata. They are hosted in repositories and then you use some form of tool like `apt` or GNOME Software to download and install the debs and all needed dependencies.

In a perfect world that would be all we ever needed, but it's not a perfect world. The biggest two are security and availability of fresh software, more about this later.

## A closer look at a snap

A deb is a bundle of files that are unpacked directly on your filesystem with an complex system that makes sure that different packages do not conflict. A snap is squashfs image with the extension `.snap`. They are mounted in to your system and are isolated from each other.

```sh
$ snap download hello-world
Fetching snap "hello-world"
Fetching assertions for "hello-world"
$ ls
hello-world_27.assert  hello-world_27.snap
$ file hello-world_27.snap
hello-world_27.snap:   Squashfs filesystem, little endian, version 4.0, 18938 bytes, 10 inodes, blocksize: 131072 bytes, created: Tue Jul 12 16:36:23 2016
```

Let's unpack the snap image and look what's inside.

```
$ unsquashfs hello-world_27.snap && tree squashfs-root
...
squashfs-root/
├── bin
│   ├── echo
│   ├── env
│   ├── evil
│   └── sh
└── meta
    ├── gui
    │   └── icon.png
    └── snap.yaml

3 directories, 6 files
```

This is a hello world snap with just a few scripts so it's tiny. The directory `meta` contains snap metadata like the `snap.yml` definition file that was used to build the snap. Most of the other directories are optional but the *usually* matches a normal filesystem layout with `etc`, `lib`, `usr` and so on.

Let us install it instead and see what happens:

```sh
$ sudo snap install hello-world
hello-world 6.3 from 'canonical' installed
```

It's installed (or should I say mounted?)

```sh
$ mount | grep hello
/var/lib/snapd/snaps/hello-world_27.snap on /snap/hello-world/27 type squashfs (ro,nodev,relatime)
```

It is mounted under `/snap/hello-world/27`, this is the snap directory path, `/snap/<name>/<revision>`. Each release to the snap store gets a new revision.

Let's query snapd for some info about our snap:

```sh
$ snap info hello-world
name:      hello-world
summary:   "The 'hello-world' of snaps"
publisher: canonical
contact:   snappy-devel@lists.ubuntu.com
description: |
  This is a simple hello world example.
snap-id: buPKUD3TKqCOgLEjjHx5kSiCpIs5cMuQ
commands:
  - hello-world.env
  - hello-world.evil
  - hello-world
  - hello-world.sh
tracking:    stable
installed:   6.3 (27) 20kB -
refreshed:   2016-07-11 23:20:44 +0200 CEST
channels:
  stable:    6.3 (27) 20kB -
  candidate: 6.3 (27) 20kB -
  beta:      6.3 (27) 20kB -
  edge:      6.3 (27) 20kB -
```

This snap contains four commands, there is a stable, candidate, beta and edge channels. We did not specify a channel on install so we got the stable channel.

```sh
/snap/hello-world/
├── 27
│   ├── bin
│   │   ├── echo
│   │   ├── env
│   │   ├── evil
│   │   └── sh
│   └── meta
│       ├── gui
│       │   └── icon.png
│       └── snap.yaml
└── current -> 27
```

It's the filesystem from earlier mounted under `27`, and there is a current symlink that points to the active version. If an update arrives it will be called `28` and be installed side by side of `27` and the symlink will be updated. The old versions are still there for some time to enable the option to roll back an upgrade, both manually by the user or automatically.

This path can be referred to as `$SNAP` inside the snaped application. Some systems like for example Fedora has moved the path to `/var/lib/snapd/snap` so always use the environment variable.

We can use the command `hello-world.env` included in the snap to inspect our environment from the inside.

```sh
$ hello-world.env | grep 'snap/' | sort
HOME=/home/nsg/snap/hello-world/27
SNAP_COMMON=/var/snap/hello-world/common
SNAP_DATA=/var/snap/hello-world/27
SNAP=/snap/hello-world/27
SNAP_USER_COMMON=/home/nsg/snap/hello-world/common
SNAP_USER_DATA=/home/nsg/snap/hello-world/27
```

`$SNAP` points to our squashfs filesystem, it's read only. `$SNAP_DATA` is a versioned writable system global storage. When we installs revision 28 the data from 27 is copied over. This allows us to have the option to roll back our data. `$SNAP_COMMON` is not versioned and is a perfect place for things that makes no sense to roll back, or really large things that we do not want multiple copies of. Finally `$SNAP_USER_DATA` and `$SNAP_USER_COMMON` are the user specific folders. Also note that `$HOME` is updated to `$SNAP_USER_DATA`.

## Security

Snaps was designed for, the now dead project, the Ubuntu Phone. It was called click packages there and snaps are just "click packages 2.0". They where designed to be installed from a untrusted source, modeled after the appstores in Android and iOS. With untrusted software a sandbox and a permission system is important.

When I install an application with apt (that installs a deb) I have to do so as root because the package installation places files all over the system. This is a security concern, any untrusted repositories have root privileges on your system.

Because snaps are contained, the content inside is never executed as root and the possibility of damage is limited. By default it can't write anywhere outside the earlier mentioned directories. Sensitive files, folders and applications are also denied access.

### Grant more access

Usually you need more access to run a snap, for that there are `plugs` (interfaces) that you can "plug your self in to" to get more access. For example with the `network` plug you are granted access to the network. Some plugs are automatically connected on install while others needs to be manually activated.

Personally I think that there is to little control here at the moment, there is no user friendly way to inspect the plugs before install and it's all or noting for plenty of plugs, like for example the home plug that grants access to the users home folder (files starting with a dot are blocked).

Early days, and I guess this is solved in a year or two. In the meantime you can unpack the snap your self with `unsquashfs` and inspect the `snap.yaml` file.

## Flatpack

It's so easy to pick a side when there are sides to choose from. I try to stay objective but like most people I tend to fail to a varying degree. There is another project out there called [Flatpack](http://flatpak.org/).

Snaps are modeled around the app stores from the mobile ecosystems with a central store. Later on it was expanded to target embeded devices like routers and IoT-toasters and servers. Flatpack on the other hand originates from xdg-app backed by GNOME and mainly targets GUI (Graphical) applications. There is no central store, it's based around a more classic style of repositories.

Both are sandboxed, contained and modern and I think there is a place for both. At the moment Flatpack more portable because Snaps depends on AppArmor and it's conflicts with SELinux that for example Fedora is using. I know that you can install snaps under Fedora today but it's not as well contained compared to Ubuntu/Debian/Solus that implements AppArmor. But these things will probably change if we give it some time.

Personally I like the idea with Flatpacks and that they are designed from start to be distribution and organization neutral. On the other hand what I like with Snaps are the easy of use with a single point to search for applications and as a creator I do not need to setup my own repositories to host an application.

## Appimage

We also have AppImage, it's a more simple approach with a mounted squashfs but no security. No repositories. You download an image and just executes it, it mounts it self and starts the application. This can be for example combined with [firejail](/post/2017/firejail/) to make it more secure.

## For applications creators

The classic repositories bundled with your distribution are usually managed by package maintainers with are usually not the same people that created the application.

A package maintainer usually do this on his or her free time and it can be a long time between a new released version and available packages. Some times packages are not updated by policy to make a release more stable and static, security updates are of course installed. The problem is that many upstream applications only applies security updates to the latest version, this forces package maintainers to backport these fixes them self to the older release and this slows things down even more.

Snaps, Flatpacks and AppImages can instead be managed directly by the creators of the software. When they makes a release, it's released to all the users. It also isolates the applications dependencies from the host operating system.

### Classic package maintainers

#### The Good

> There is a single source of trust

If you install packages from your distribution repositories you know that it's vetted by your distribution and that is secure and safe to install.
 
> The software is packaged for you

It is packaged for your distribution and it will work better, have a smaller footprint.

> A project can patch an application

You distribution can patch and application if a security problem occurs even if the upstream application is slow to do so.

> Security updates to shared libraries applies system wide.

If a security problem occurs inside a shared library, it is much easier to patch.

#### The Bad

> The versions in the repositories are sometimes out of date

Sometimes the packages are really old and most fast moving projects do **not** recommend you to use the packages in the repositories. The alternatives are often badly managed 3rd party repositories or scripts that promotes bad practices and may lowers the security.

> Non-free applications can't usually be published in the normal repositories

We end up with really badly written install custom install scripts from software vendors.

> The application may have security updates applied but the package maintainer is slow to update the package.

This is most likely for smaller well known packages.

> Even an application that is not executed as root has root permission during install time.

This is mostly a problem in 3rd party repositories. But most people have at least a few installed. If any of these repositories are compromised they can publish an infected package.

### Sandboxed packages

#### The Good

> It's sandboxed

If the application tries to do something nasty, it is sandboxed and can't do to much damage the to host system. This do of course depends on what permissions the package has.

> The application can be updated and all users get the latest version.

A lot of people like new shiny things, and this reduces the chance to need unsafe and/or shady install techniques.

> More secure for most users

I have seen people just install random things from random sites without thinking to much of it. No verification, just install it to get the latest shiny.

For most people the sanboxing will be a huge security improvement.

> Easy to distribute software to users.

No need to worry about library versions, just package everything that you need inside the package.

#### The Bad

> You have to trust every package/publisher.
 
The sandbox helps to compensate for this. I have been waiting for this model to arrive for years. There are plenty of things out there that I trust enough to run it on my system inside a sandbox, but not to grant it superuser root access.

> It's possible that the packages never was tested on your distribution.
 
But this is also true for many third party solutions.

> The creator of the package may not follow good security practices and libraries may be old with security vulnerabilities.

This is always a problem, and this is one of the bigger security problems with this model.

## Finally

I guess time will tell what happens next, but with the success with appstores on the mobile platforms it only makes sense that we would see the same thing happen on more classic systems. On my Android phone I always do a quick audit of the application I like to install. Do the publisher look trustworthy? Is there a lot of downloads? Does it feel safe? If the answers to that is yes I check the permissions it requires and if that's okay I choose to trusts the the security model holds and keeps my data safe.

I have waited a long time for that to be true on my desktop system, today it is all or nothing. When I add a PPA I grant the maintainer full access to my system and I feel the need to have a completely different level of trust. There are few PPA:s and 3rd party repositories that I trust for that. I feel that snaps and like is a step in the right direction, and I like that!
