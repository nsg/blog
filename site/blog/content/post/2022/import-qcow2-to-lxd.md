+++
date = "2022-01-29T12:00:00+01:00"
title = "Import a qcow2 image to LXD"
tags = ["qcow2", "lxd"]
+++

I recently learned how to make my own LXD VM image based on Home Assistant's QCOW2 VM images. This blog post is a short write-up how to do that! This is of course useful for other qcow2 images as well.

## Download a image

I downloaded the [Home Assistant OS](https://www.home-assistant.io/installation/linux) image in the qcow2 format, and uncompressed it. The image is intended for KVM, and LXD runs VM:s with Qemu/KVM so it's a good fit for LXD VM:s.

```sh
$ wget https://github.com/home-assistant/operating-system/releases/download/7.1/haos_ova-7.1.qcow2.xz
$ xz -d haos_ova-7.1.qcow2.xz
```

## Write a metadata.yaml file

LXD need some metadata, the format is [documented here](https://linuxcontainers.org/lxd/docs/master/image-handling/#image-format). A minimal example that I used for Home Assistant can be found below:

```yaml
architecture: x86_64
creation_date: 1643062675
properties:
  description: Home Assistant OS 7.1
  os: HAOS
  release: 7
```

Save it as metadata.yaml, and make it a tarball with:

```sh
$ tar cf metadata.tar metadata.yaml
```

## Import the image

Import the image as `haos` with an image import:

```sh
$ lxc image import metadata.tar haos_ova-7.1.qcow2 --alias haos
```

## Launch it!

That's all, now start it like any other VM with the `--vm` flag. LXD will only launch signed images with secure boot by default, to disable that add `-c security.secureboot=false`. The full command I used to launch this specific VM was:

```sh
$ lxc init haos homeassistant --vm \
  -c security.secureboot=false \
  -c limits.cpu=2 \
  -c limits.memory=4GiB
```

That's all!
