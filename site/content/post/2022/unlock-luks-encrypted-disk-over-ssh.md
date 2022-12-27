+++
date = "2022-02-12T00:20:00+01:00"
title = "Unlock LUKS encrypted disk over SSH"
[taxonomies]
tags = ["luks", "ssh"]
+++

I just realized how easy it is to unlock the disk encryption password on a remote and/or headless server via SSH. There is a package called `dropbear-initramfs` that does exactly what is sounds like, it embeds a dropbear SSH server inside initramfs, cool!

## Install and configure

```bash
apt install dropbear-initramfs
```

Edit `/etc/dropbear-initramfs/config` and use something like this:

```bash
DROPBEAR_OPTIONS="-j -k -p 2222 -s -c /usr/bin/cryptroot-unlock"
```

Place a public key in `/etc/dropbear-initramfs/authorized_keys`, regenerate the initramfs and you are done!

```bash
update-initramfs -u
```

## Unlock

During boot the system will wait for you to SSH in and provide the key, it's a normal SSH session like this:

```bash
$ ssh 10.0.0.10 -p 2222 -l root
Please unlock disk dm_crypt-0: 
cryptsetup: dm_crypt-0 set up successfully
Connection to 10.0.0.10 closed.
```

Now everything boots normally!
