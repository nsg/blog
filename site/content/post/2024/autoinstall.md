+++
date = "2024-04-27T22:55:00+02:00"
title = "Ubuntu 24.04 with autoinstall.yaml"
[taxonomies]
tags = ["ubuntu", "autoinstall", "zfs", "encryption"]
+++

I recently installed the newly released Ubuntu 24.04 LTS on my laptop. Canonical has introduced a revamped installation interface, which is visually appealing. However, I found that the options for manual disk configuration are limited. For instance, I couldn't manually set up LUKS encrypted partitions or utilize LVM. While the GUI lacks functionality in this aspect, you can on the other hand define any desired configuration in `autoinstall.yaml`.

## My usual layout

On my old installation I picked automatic installation with disk encryption, and with that I ended up with a classic ESP and Boot partitions and the rest in LVM on a LUKS-encrypted partition like below.

```
+-----+------+---------------------------------+
| ESP | Boot | LUKS                            |
+-----+------+---------------------------------+
             | LVM                             |
             +---------------------------------+
             | root               | swap | ... |
             +--------------------+------+-----+
```

Easy, but I have all my stuff (applications, configuration, document, code, ...) in a single partition. I have put of a reinstallation for almost a year because I need my computer, and I haven't found the time to nuke everything, reinstall, configure and move my data back.

I have some basic desktop provisioning that speeds up _some_ of the application installation and configuration, but that's aging and most of the logic reflects my needs a few years back. I have changed, and so has the tech that I'm using so it's not that usable anymore.

I needed something new, to avoid finding myself in the same spot a few years down the line! In classic nsg fashion I started to over-engineer it a little (a lot!). I got a grip and realized that I need to scale it back. So this blog post will document what I ended up with, not my final vision. At least I have moved the needle a step closer to something better.

## Basic idea

Separate my "state" from the installation. When convenient use containers or similar to separate applications from the base operating system. My vision is to keep it fully separated but this iteration of the installation will only partly separate things to keep things simple so I have a useable computer again.

Part of this separation is to have a ZFS Pool for all my data. Everything else should be re-creatable quickly and easily. My vision had an idea of an immutable-ish system with image based updates but I have scaled down that approach to just a normal Ubuntu installation and a promise to my self to keep it clean.

```
+-----+------+------------+-------------------------+
| ESP | Boot | LVM        | ZFS                     |
+-----+------+------------+------+------------------+
             | LV   | ... | home | Containers | ... |
             +------------+------+------------------+
             | LUKS |
             +------+
             | root |
             +------+
```

My home folder contains most of my stuff, I have created a specific dataset for that called `home`. I also have datasets like for example `home/code` that contains my different code workspaces. This allows me to easily snapshot and backup the datasets.

A `zfs send` allows me to do really frequent and efficient backups to my server. A restore would be super easy as well.

Other state that I care about (like Incus containers/VMs) uses a ZFS dataset as well. I run my Podman containers as an unprivileged user so it's state is stored under `.local/share/containers/`. Flatpak's are installed as a user and their data is stored under `.local/share/flatpak/` and `~/.var/app`.

What's left is classic apt-packages and snaps. They store their state inside the `root` partition in the above layout. The idea is to minimize the needed applications installed here, install whatever I can in Incus or Podman. But for the rest I will write a few simple bash script that should provision these applications.

So in theory, I should be able do a clean install on top of this. Keep the ZFS pool. Run my provision and have all my state back. In theory, hence the importance of the backups.

## Autoinstall

Initially, I thought, just do a manual installation of the above layout. The problem is that the new installer is lacking any advanced partition options. No problem I thought, I will just prepare the partition myself. That did not work either because the new installer was not clever enough to allow my to select LVM or LUKS encrypted drives.

I considered to change distribution, but I do a lot of things inside the snap ecosystem and I like that Ubuntu has great support for ZFS. I also support a Ubuntu based image for work. So, staying on a Ubuntu base do make sense for me. I also do not mind GNOME so the flavours was not a good fit either.

Ubuntu Server has supported a new installation provision called Autoinstall for a few years, replacing the Debian preseed logic. The desktop installer gained support for this with this release. So I used this to solve my partition problems, I manually configured my partitions in yaml, and pointed the installer to my `autoinstall.yaml`.

It can be a little tricky, I will explain. I will focus on the `storage` section here.

```yaml
storage:
    config:
      - id: disk0
        name: disk0
        type: disk
        ptable: gpt
        preserve: true
        grub_device: false
        match:
          ssd: true    
```

I used `match` to find a `ssd`. If you have several flash based drives in your system. Update the match to it finds the correct drive. You can match on "smallest drive", serial number and so on. I called the drive `disk0` with the `id` parameter. `grub_device` should be `false` on the disk on EFI installations.

Note the `preserve` keyword is set to `true`. With that, the installer only validated the state. Otherwise it would have formatted the drive if needed. The installer is not to informative what's going on, I recommend that you run a `journalctl -f` in a terminal during installation to catch any errors. That's easier and will save you time!

```yaml
      - id: esp
        type: partition
        device: disk0
        size: 1G
        flag: boot
        number: 1
        wipe: superblock
        grub_device: true
        # preserve: true
```

The above code configures the ESP partition, here called `esp`. This is a new install for me so I choose to wipe the partition. If you like to keep the data on this drive, uncomment the preserve keyword and remove wipe. For future reinstallations, this is exactly what I will do.

```yaml
      - id: esp-format
        type: format
        fstype: fat32
        volume: esp
        # preserve: true
```

The above formats the `esp` partition with fat32. Good 'ol horrible outdated filesystem that we standardized on, yey! Let's move on the our first Linux specific partition.

```yaml
      - id: boot
        type: partition
        device: disk0
        size: 2G
        number: 2
        # preserve: true
      - id: boot-format
        type: format
        fstype: ext4
        volume: boot
        # preserve: true        
```

Nothing special here, this partition did not exist on my drive so no need for a wipe. Nothing special here really. Note the `number` keyword that specifies that this is partition number 2.

Let's move on to something more interesting. I picked something a little unusual. Instead of LVM in LUKS, I pricked LUKS in LVM. Time will tell of this is a mistake, but I hoped this allowed me more future flexibility if I finds time to expand on my vision.

```yaml
      - id: root
        type: partition
        device: disk0
        size: 80G
        wipe: superblock
        number: 3
        # preserve: true
      - id: vgroot
        type: lvm_volgroup
        name: vgroot
        devices: [root]
```

Partition 3 is 80G and I formatted it with LVM and added it to a volume group called `vgroot`. The LVM layer do not add any value for me at the moment, but I like the flexibility of LVM. I considered ZFS here but I quickly found a few compatibility problems and was tired to troubleshoot experimental installation options.

**Note**: It's possible that the installer will remove any partition not added to the yaml. So If you tries to reuse an existing LVM volume group with pre-existing volumes. Make sure that you specify all partitions, or at least make a backup if you like to keep them.

```yaml
      - id: lvroot
        type: lvm_partition
        name: lvroot
        volgroup: vgroot
        wipe: superblock
        size: 20G
```

Leave plenty of space for future experiments, and with only `20G` I hope this will motivate me to keep things on ZFS.

```yaml
      - id: luroot
        type: dm_crypt
        dm_name: luroot
        volume: lvroot
        key: banan
```

Setup LUKS encryption, specify the key `banan` (that's banana in Swedish). I will obviously change this later. It was easier to just specify a "temporarily installation password" and change it post-installation.

```yaml
      - id: luroot-format
        type: format
        fstype: ext4
        volume: luroot
```

Format the filesystem inside LUKS to `ext4`, this will be used as our `/` filesystem. Now it's time to configure ZFS. **Please note** that I suspect that partitions, volumes, pools, ... not specified _may_ be removed by the installer. So make sure that have backups, and that you specify everything marked with the `preserve` keyword set to `true`.

```yaml
      - id: pool_part
        type: partition
        device: disk0
        size: -1
        number: 4
```

A `size` set to `-1` is shorthand for "use the rest of the disk". Now, it's time for our pool!

```yaml
      - id: pool
        type: zpool
        pool: pool
        vdevs: [pool_part]
        mountpoint: /pool
        pool_properties:
          version: null
          ashift: 12
          autotrim: "on"
        fs_properties:
          acltype: posixacl
          xattr: sa
          compression: lz4
          normalization: formD
          relatime: "on"
```

Confusingly I like to call my pool, `pool`. I specifies a few properties with inspiration from OpenZFS wiki. Curtain (the tool that Autoinstall uses) sets the pool version to `28` by default for maximum compatibility. That's an ancient version, that you most likely do not need. Set it to `null` to allow ZFS to use a recent by ZFS default version for the pool. If you prefer to use version `28`, note that many properties specified above are not available.

Finally mount the volumes to their appropriate places, in order.

```yaml
      - id: luroot-mount
        type: mount
        device: luroot-format
        path: /
      - id: boot-mount
        type: mount
        device: boot-format
        path: /boot
      - id: esp-mount
        type: mount
        device: esp-format
        path: /boot/efi
```

Above is the classic partitions provided by Ubuntu. Nothing special, nothing fancy.

```yaml
      - id: home
        type: zfs
        pool: pool
        volume: home
        properties:
          mountpoint: /home
```

Finally let's create our home dataset. I did this down here so the mounts happened in the correct order. **Note** that this dataset is not encrypted. I choose not to encrypt it at this stage to make life a little easier for me. I fixed that post installation instead, more about that below.

## Post-installation

Installation completed, I'm now booted in to my new system.

### Add ZFS native encryption to pool/home

There is no way to add encryption to a dataset, but you can send the data to a new encrypted dataset. First, 
create a encryption key and place it on the LUKS encrypted partition.

```sh
dd if=/dev/random bs=32 count=1 of=/etc/pool-key
chmod 400 /etc/pool-key
```

Now use that to create a new dataset based on my current one. First take a snapshot, then use that to send the data to it's new location.

```sh
zfs snapshot pool/home@t
zfs send -R pool/home@t | zfs receive -o encryption=on -o keyformat=raw -o keylocation=file:///etc/pool-key pool/home2
```

We are now in an interesting state with both `pool/home` and `pool/home2` mounted as `/home`. Let's redirect the old dataset, and reboot.

```sh
zfs set mountpoint=/pool/oldhome pool/home
reboot
```

Verify that `/home` uses `pool/home2`, and that it's encrypted.

```
# df /home
Filesystem     1K-blocks   Used Available Use% Mounted on
pool/home2     398134144 764544 397369600   1% /home
# zfs get all pool/home2 | grep -E 'encrypt|key'
pool/home2  encryption            aes-256-gcm               -
pool/home2  keylocation           file:///etc/pool-key      local
pool/home2  keyformat             raw                       -
pool/home2  encryptionroot        pool/home2                -
pool/home2  keystatus             available                 -
```

Now remove the old dataset with a `zfs destroy -r pool/home`. All done! To rename home2 to just home again, look closer at `zfs rename`.

### LUKS encrypted drive

Let's change the encryption key from `banan` to something more secure.

```sh
cryptsetup luksChangeKey /dev/mapper/vgroot-lvroot
```

That should do it!

### Provision

I have updated my old [dotfiles](https://github.com/nsg/dotfiles) repository. That should install and configure a few "must haves" to get me going. A few other items are restored from backup.

... and I'm ready to go! I will probably write a follow up post later on focusing on containers and stuff. First item on the agenda, time to do an [Immich Distribution](https://github.com/nsg/immich-distribution) release!
