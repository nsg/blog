+++
date = "2016-10-29T22:07:00+01:00"
title = "Phone Update"
[taxonomies]
tags = ["Ubuntu Touch"]
+++

In about a week from now, I have had my Ubuntu Touch phone for two months. I have got used to some aspects of it but I still finds fun and interesting things to do with it. Is it a pain? Yes, indeed it is, more or less all applications that I daily use are worse than the Android equivalent and I have been thinking about the possibility to buy an Android phone, the Pixel do indeed looks interesting. But, still, I remember why I'm trying to leave Android and it feels a little better. It is a roller coaster of feelings and frustration.

Still, I was expecting a somewhat buggy phone, and I was ready to live with it. But considering that the phone was in stores I was expecting something a little more stable and usable.

## The good
### I'm still using it
I hoped to give it tree months, and my intended way out if it was unusable or not my thing was to buy a new Android phone. There has been a lot of frustration, and I do think the UI needs *a lot* of work, but I'm still using it.

### Pebble
I have my [pebble connected](https://launchpad.net/rockwork) and can use it to look at calendar events, get notifications and control the playback. The bluetooth caused me some problems about a month ago when I paired it, but it has been rock stable now.

### Podcasts
[Podbird](https://launchpad.net/podbird) is buggy, but it works and I can live with a crash from time to time. A few times a week, it will lose track of where I was after a few hours, and sometimes the playback will be messed up when I fast-forward. Just a easy close and open again will alway fix it.

At the moment I'm experimenting to use the default [Music player](https://developer.ubuntu.com/en/community/core-apps/music/) to play the podcasts, but still use Podbird to download the shows. I did a simple symlink:

```
cd Music
ln -s /home/phablet/.local/share/com.mikeasoft.podbird/podcasts .
```

### It's a computer
This is one of the things that I really like, It's a computer that I can SSH in to and manage.

### Nextcloud

Pictures and files are synced with my Nextcloud install with the [Owncloud-sync](https://launchpad.net/owncloud-sync) application. Works perfectly. I use the build in sync provider to sync my calendar and contacts, more about that later. I have spent quite some time experimenting with different solutions to get my work calender *correctly* synced to my phone. I will write a separate post about this later.

### X Apps
I can actually use classic desktop apps in the phone with [Libertine](https://wiki.ubuntu.com/Touch/Libertine). Then of course "use" can be a strong word, the apps are tiny on the screen and my fingers are large. This is of course much more usable if you uses an external monitor.

## The bad

### To busy
I have been to busy to solve or research may of my problems and find fun things to do with the phone. For example, my work calendar, I found my current solution about a month ago but I never had the time to try it out.

### Bluetooth
[Bluetooth is buggy](https://bugs.launchpad.net/canonical-devices-system-image/+bug/1590844), and it looks like some problem with the BT firmware and the operating system. Calls over BT is a no-go, no big problem for me, but podcasts, I love to use a BT headset. There are good days where the sound just drops for a second or two once every 5-10 minutes or so, and there are bad days where it's unusable. I have been using the good old 3.5mm jack a lot.

### Big!

Oh my good the phone is big and slippery (metal), I have considering to fix the slippery part but I hate cases and never uses them. Size is something that it's annoys me, it is hard to use it with one hand and a phone is a one hand device ... in bed, in the subway (need a had to hold me in place, or for coffee, ...). At least, the size in the pocket is no big deal, it is quite thin and light.

### Camera
The hardware is good, but software-wise I miss more advanced features, like for example good algorithms to pick a good exposure, or manual controls. And I do miss HDR, and the possibility to use the 120FPS camera would be fun.

### Slack
Still no way to use Slack at the phone, I have used my work phone a lot to work around this problem but It's annoying to carry two phones when I go to meetings so I hope that this will be solved soon. Slack has a XMPP that I intended to use but to my surprise there are no XMPP client.

## Over all

It's a fun phone, and it's a annoying phone. We will see if I still uses this next year, I hope so, because I really hope that I get everything that I need working, and then, I hope that there are a smaller model to buy some time next year.
