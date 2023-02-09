+++
date = "2023-02-09T18:00:00+01:00"
title = "Holy ZFS Bug!"
[taxonomies]
tags = ["zfs", "encryption", "server"]
+++

![](/images/2023/zfs-broken.png)

[Almost exactly a year ago](@/post/2022/encrypted-zfs.md) I restructured my storage setup. I have always been careful with my files and that's why I moved over to ZFS on my storage server. No [rotting bits](https://en.wikipedia.org/wiki/Data_degradation) here! One of the new things with my new setup is native ZFS encryption.

I have been playing with [a little project](https://github.com/nsg/immich-tools) that resulting a lot of small read and writes to one of my datasets, `pool/encrypted/pictures`. It contained a folder mounted at `/pool/encrypted/pictures/phone-sync/stefan/pixel4/camera/`.

I noticed an interesting behavior, I was unable to list or access anything inside `camera`. An `ls` just got stuck. Other folders in the dataset worked just fine, I was able to read and write. I scrached my head and thought it was related to the volume mounts I had done on top of it. `camera` is mounted in to two LXD containers with the relatively new `shiftfs` feature. One of LXD containers also had Docker that volume mounted the folder. I blamed Docker (like you do) and rebooted, and everyting was just fine... for about a day. Then exactly the same thing happened and this time a reboot resulted to the following nice message.

```
  pool: pool
 state: ONLINE
status: One or more devices has experienced an error resulting in data
	corruption.  Applications may be affected.
action: Restore the file in question if possible.  Otherwise restore the
	entire pool from backup.
   see: http://zfsonlinux.org/msg/ZFS-8000-8A
  scan: scrub repaired 0B in 0 days 01:39:36 with 0 errors on Mon Feb  
        6 18:54:18 2023
config:

	NAME                                 STATE     READ WRITE CKSUM
	pool                                 ONLINE       0     0     0
	  raidz1-0                           ONLINE       0     0     0
	    ata-ST8000VN004-2M2101_A         ONLINE       0     0     0
	    ata-ST8000VN004-2M2101_B         ONLINE       0     0     0
	    ata-ST8000VN004-2M2101_C         ONLINE       0     0     0

errors: Permanent errors have been detected in the following files:

        pool/encrypted/pictures:<0x0>
```

I _think_ the nightly backup triggered this, but I'm not sure. The good thing is that I have offsite backups of the dataset, so no panic. All the other datasets worked just fine, and a few of them had no backups, so I started by fixing that. I also did a scrub, updated the system and so on... no success here, but at least I have improved my backup game.

This bug is really similar to my problem: [Filesystem can not be mounted: Input/output error #13521](https://github.com/openzfs/zfs/issues/13521) and to summarize:

> Well, you're running a 2+ year old version with known bugs (not that the latest version of native encryption doesn't also have a host of known bugs nobody's fixed), so perhaps you should consider not doing that.

That's scarry, I starting to wounder if it was a good idea to trust ZFS native encryption. When I installed this server a year ago the latest released Ubuntu LTS was 20.04 released in April 2020 and version 0.8.3 [was released](https://github.com/openzfs/zfs/releases/tag/zfs-0.8.3) in January 2020. It make sense the 20.04 was based around that release.

> The current series of releases is 2.1.x, you are on 0.8.x. /.../ you could always try reporting your issue to Ubuntu's bugtracker in that case, as I would be pretty astonished if 0.8.x saw any fixes or releases ever again here.

Classic problem with distribution that moves slowly and a project that moves on and never looks back. I'm sure that Canonical backports a lot of fixes to the 0.8.x branch, but this obscure bug was probably never backported.

> /.../ looks more like the user accounting MAC issue which was fixed in #12981 a couple of months ago. So I'd say a recent ZFS version (2.1.4 or git@master) should be able to mount the datasets, at least it's worth a try.

Ubuntu 22.04 LTS was releases in April 2022, it ships with 2.1.4 who was releases in Mars 2022, so I upgraded. With a fresh new upgraded OS I once again did a scrub (just in case) and tried to mount the dataset. The problem was still there, but that was expected.

```bash
# Send the raw dataset to a new dataset
zfs send -w pool/encrypted/pictures@export \
  | zfs recv pool/encrypted/pictures2

# Set encryption key, load it and finally mount the dataset
zfs set keylocation=file:///my/key pool/encrypted/pictures2
zfs load-key pool/encrypted/pictures2
zfs mount pool/encrypted/pictures2
```

🎉 Yey! My files are back. I renamed and moved the mountpoint back to their proper locations. I have saved the broken dataset for now, but I will destroy it later this year.

```bash
zfs rename pool/encrypted/pictures pool/encrypted/pictures-borked
zfs rename pool/encrypted/pictures2 pool/encrypted/pictures
```

Time to verify that pictures are fine, I'm using [Restic](https://restic.net/) for backups and each backup creates a Restic snapshot. The most efficient way to verify that is to run a backup with the `--force` flag and then compare the latest snapshot with an old known good one.

`--force` will re-read all files on disk and upload changes, it will take time but it's much faster (and cheaper) compared to download the entire archive from the cloud and locally compare the files.

```bash
# Force re-reading the target files/directories
restic backup --force ...
```

Now list all snapshots, filter for the pictures folder.

```bash
restic snapshots --path /pool/encrypted/pictures/.zfs/snapshot/restic-backup
```

Compare a backup done last week with the one I just compleated.

```bash
restic diff -v 837c45c6 d130d836
```

I only see changes that I expect in `camera`, so, all good! 🥳

I really hope that this is the last time I see this specific bug, and I hope that I will not see any more, anytime soon.
