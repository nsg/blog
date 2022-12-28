+++
date = "2018-09-23T12:22:55+02:00"
title = "How I bricked by new Lenovo"
[taxonomies]
tags = ["lenovo", "brick", "x1 yoga", "s3", "s0i3", "bios"]
+++

I did it, I finally bought a laptop computer. I'm not writing this on the new laptop, and this is the reason and my journey.

I have been a full time Linux user for over the course of a decade, and part time for another ten. The last 10 years or so things have been mostly free from troubles. As a laptop I have been using an Asus UX31A, and it has been rock stable with almost no problems. My workstations has been custom built or Intel NUCs, all with excellent hardware Linux support. For work, I have had a Dell XPS 13 9350 for almost three years with only minor problems.

So I did expect the install of my new Lenovo X1 Yoga 3gen to be smooth. I did expect to have a good experience and to be up and running quickly.

## Firmware upgrade

Before I started I used the included official tools in Windows to update the firmware. NVME and ME had updates so I applied them.

## Ubuntu

I did a more or less default UEFI install with disk encryption. Everything just carried on as expected and it took the usual 5 minutes or so. I played around in Ubuntu for an hour. The pen works and I was able to draw, Krita detected both the pressure and buttons. Tablet mode worked nicely. I tried most hardware except ethernet, NFC, LTE, and fingerprint reader.

At this point I was happy, a few annoying things but they where software related and some would probably be fixed with a newer kernel, some with a few tweaks, a few minor problems on new-ish hardware was to be expected.

## Missing S3 power state

I used the computer a little during the evening and closed the lid, I suspected that suspend did not work as expected because the computer was a little warm. Next morning the battery was dead and I had to plug it in. It had consumed a lot more power sleeping than expected. Apparently Lenovo have *replaced* the S3 power state (Suspend to RAM) with a new power state called S0i3, that's a new power state with flaky Linux support.

Apparently Windows has for some crazy reason written code that *only* works with S0i3 if S3 is missing so Lenovo can't just ship them with both S3 and S0i3. The hardware actually supports both, it's just a question of what type of support that is announced to the OS.

I found that the sister model, the X1 Carbon Gen 6 computers had an option to enable S3 (and disable S0i3) in BIOS, so I rebooted and looked around but it's not there in the X1 Yoga series. But when I was poking around I did find and option called "Thunderbolt BIOS Assist" that was disabled, in the description it told me that I should enable it for Linux support. Sounds good, sure why not!

## Thunderbold BIOS Assist

![Lenovo BIOS Thunderbolt Auto Assist](/images/2018/lenovo_bios_tb_auto_assist.jpg)

When enabled it told me that it could take up to 15 seconds after a reboot. Maybe one of two minutes later I was sitting there with the computer in my lap waiting with a black screen with spinning fans. I put the computer down and left it alone in case it did read it wrong, maybe it was 15 minutes? After maybe 30-40 minutes of TV watching I returned an tried to power cycle it little luck. That's all the computer does at the moment. Back light on, black screen and fans spinning. Caps locks lamp responds.

I found a several month old support thread on the Lenovo forums talking about exactly this problem.

https://forums.lenovo.com/t5/ThinkPad-X-Series-Laptops/Thinkpad-X1-Yoga-3rd-Gen-Stuck-at-Black-Screen-After-Enabling/td-p/4106952

> "Hello, exactly one week ago, I changed enabled 'Thunderbolt BIOS Assist' in the BIOS to support Linux.  Following this, the system refused to boot to anything but a black screen.  Thus, I sent the machine in for depot repair.  I just received the machine back again today and the same thing occurred after enabling the same setting." - OnyxDelta

Two days later an Lenovo Employee responds with

> "development team is aware of this issue." - Lenovo

... okay, and you did leave bricking options in BIOS for several moths, and no warnings? A little later they suggested

> When the Thunderbolt BIOS Assist Mode is enabled, BIOS changes the PCI device handling mode.  That action might lead BIOS to black screen hang situation. 

okay...

> In order to make the system H/W to be reset, I'd like customer to try removing all the batteries ( main batery and coin-cell battery) once.

With a lot of replies that told them that this did not fix it, I did try this just in case, no luck. I also tried to remove a few PCI devices like WIFI and LTE modem with no luck.

It's not only my model that has this problem, for example P52: https://forums.lenovo.com/t5/ThinkPad-P-and-W-Series-Mobile/Lenovo-P52-bricked-by-selecting-BIOS-thunderbolt-support-for/td-p/4207538

## What now?

I'm not really sure! There is plenty of people in the thread that had re-bricked their devices after they got it back, it sounds like "a fix" is to re-flash the working but flawed BIOS firmware, or possible replace the mainboard with the same flawed BIOS version.

I feel betrayed that they know about this problem and still allows users to brick their computers. They have released firmware upgrades since. I understand that it's possible that they have not yet found a solution, but if that's the case, why not add a warning? Or, even, remove the option until it's fixed?

The S3/S0i3-thing can I live with, I can use hibernate until I either Linux get better S0i3 support, or Lenovo allows me to enable S3 (my preferred because S3 has lower power usage and S0i3 adds nothing I like to use).

But what do I do with Thunderbolt BIOS Assist Mode, will I ever again be brave to enable that again? How is the Linux support without it?

It saddens me that my first Lenovo experience is this horrible, tomorrow I will contact the store and possible then Lenovo to get this thing sorted.
