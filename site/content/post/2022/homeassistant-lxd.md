+++
date = "2022-01-29T13:00:00+01:00"
title = "Run Home Assistant OS inside LXD"
[taxonomies]
tags = ["Home Assistant", "homeassistant", "lxd"]
+++

My Home Assistant installation running on a [rpi3b+](https://www.raspberrypi.com/products/raspberry-pi-3-model-b-plus/) finally failed. More precisely, the SD card failed. No big surprise, I was expecting this and had planned a replacement for some time but I never got to in in time. The good this, I had a recent backup so it's all good! Backup people!

## New install

Instead of just throwing in a new SD-card and just carry on like before, I choose to do a proper install this time on one of my home servers. My server has the following layout:

* Ubuntu 20.04 LTS
* LXD (with a ZFS volume as storage)

The storage is two mirrored SSD:s so a single failed storage drive will not kill this install again. It's also fast, and the COW filesystem will make LXD snapshots efficient and fast.

## Prepare the system

I created a LXD image based on the KVM image of Home Assistant OS published by the project. You can read how I did that in the blog post [Import a qcow2 image to LXD](@/post/2022/import-qcow2-to-lxd.md).

## Launch Home Assistant OS

I use init (instead of launch) to create a stopped VM. Home Assistant OS images are not signed so we need to turn secure boot off, two CPU cores and 4GiB RAM feels about right. `haos` refers to my [Home Assistant OS image](@/post/2022/import-qcow2-to-lxd.md).

```sh
lxc init haos homeassistant --vm \
  -c security.secureboot=false \
  -c limits.cpu=2 \
  -c limits.memory=4GiB
```

Home Assistant do not use that much disk space, but I bumped it to 64GiB to be on the safe side for the future, the actual on-disk allocated disk space should be a lot lower, especially if you use ZFS compression. My entire restored installation uses around 5.3GiB.

```sh
lxc config device override homeassistant root size=64GiB
```

All done, just launch it and dive it a minute or two to show up in the network.

```sh
lxc start homeassistant
```

I waited about a minute and imported my backup via the browser and I was back in action. More or less, I still had a few things to do to be fully back with full functionality. Moving on!

## Add IOT network

IOT things are rarely secure so they are on a isolated network, I had already prepared an profile called network-iot that I added to the VM like this:

```sh
lxc profile add homeassistant network-iot
```

After a reboot I found my self in trouble ...

## Access the installation via the graphical console

Home Assistant OS has a really simple Network Manager profile called "Home Assistant OS default" that picks whatever interface it finds first. This is probably an okay default but caused problems for me, because the new IOT-network ended up as the configured one, so I lost access to the install from my Laptop.

You can launch a graphical console session with `lxc console -t vga homeassistant`, just a tiny bit of a problem, my server is headless. A nice thing with LXD is that it's possible to run the client part of it on another computer like my laptop so that is what I did!

Expose the daemon over the network, unless already configured of course. I picked a specific IP instead of the more broader `0.0.0.0` to limit it to my LAN only.

```sh
lxc config set core.https_address 192.168.1.123
```

Set a secret trust password, you need this when you add clients:

```sh
lxc config set core.trust_password my-long-and-secret-password
```

I added my server **on my laptop** with the `lxc remote`-command like this:

```sh
lxc remote add myserver https://myserver.example.com:8443
```

It's now possible to access the console **from my laptop** with:

```sh
lxc console -t vga myserver:homeassistant
```

To get a real shell, type login.

## Add support for another network interface

Inspect your interfaces with `nmcli` and/or `ip a` to find out the names of your network interfaces. For me I have `enp5s0` and `enp6s0`.

Remove the default network, and add two new, one for each interface.

```sh
nmcli c delete "Home Assistant OS default"
nmcli c add type ethernet ifname enp5s0 con-name "LAN Network"
nmcli c add type ethernet ifname enp6s0 con-name "IOT Network"
```

This should do it! On my old installation (on the [rpi3b+](https://www.raspberrypi.com/products/raspberry-pi-3-model-b-plus/)) the LAN was served over WIFI, and the IOT-network over the ethernet port. More or less the same logic like above, just a little more WIFI configuration for one of the interfaces.

## Connect my Telstick Duo (USB device) to the VM

Make sure that you can see the TellStick with the `lsusb`-command, note the IDs:

```sh
$ lsusb | grep TellStick
Bus 002 Device 003: ID 1781:0c31 Multiple Vendors Telldus TellStick Duo
```

On a stopped VM, run the following command:

```sh
lxc config device add homeassistant tellstick usb vendorid=1781 productid=0c31
```

## Summary

I'm back up and running. I would have been more efficient to run Home Assistant in a LXD **container** instead of the Home Assistant OS **VM**, but I gladly payed with some lost resources to get a more easy to maintain setup. I expect this image to "just work" for years. I will add snapshots to the VM:s later on, but that's another day!
