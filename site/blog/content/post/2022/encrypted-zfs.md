+++
date = "2022-02-12T13:20:00+01:00"
title = "Encrypted ZFS"
tags = ["zfs", "encrypted"]
+++

Last night I installed a new server with an [LUKS encrypted drive](/post/2022/unlock-luks-encrypted-disk-over-ssh/). The server also has a large ZFS pool that is used as the main data storage, of course that needs to be encrypted as well.

If you just like to know how ZFS encryption works, I recommend that you read [Jim Salter's excellent article about it](https://arstechnica.com/gadgets/2021/06/a-quick-start-guide-to-openzfs-native-encryption/).

Compared to LUKS, ZFS encryption is a feature you enable on datasets/volumes. This has the disadvantage that you can see the structure and metadata of unlocked datasets/volumes. For example the name of a dataset, disk usage and so on. This is most likely not a problem, but a minor detail that is good do know.

```shell
zfs create \
    -o encryption=aes-256-gcm \
    -o keylocation=file:///etc/zfs-disk-encryption-key \
    -o keyformat=passphrase \
    pool/encrypted
```

I can now place whatever datasets/volumes I prefer to keep encrypted under `pool/encrypted`. I picked the name "encrypted" to make it obvious for future me to understand what is encrypted and what's not.

I run LXD containers on this server, they will be stored under `pool/encrypted/lxd`. It's important that the dataset is unlocked before lxd starts. The root is encrypted with LUKS so I felt comfortable placing the encryption passphrase inside a file. If you do this, make sure that you have a second copy of the file (or it's something you remember). It would be annoying to lose access to the ZFS dataset just because the OS drive failed.

[ArchWiki has a nice systemd service](https://wiki.archlinux.org/title/ZFS#Unlock_at_boot_time:_systemd) that unlocks the dataset at the appropriate time. I had to modify the path slightly for Ubuntu, here it is:

```ini
[Unit]
Description=Load encryption keys
DefaultDependencies=no
After=zfs-import.target
Before=zfs-mount.service

[Service]
Type=oneshot
RemainAfterExit=yes
ExecStart=/usr/sbin/zfs load-key -a
StandardInput=tty-force

[Install]
WantedBy=zfs-mount.service
```

And of course, do not forgot to enable the service with a `systemctl enable zfs-load-key.service`.
