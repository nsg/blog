+++
date = "2024-10-06T11:45:00+02:00"
title = "Google Rant and Dark Patterns"
[taxonomies]
tags = ["Google", "Google Photos", "Dark Pattern"]
+++

{{ image(src="/images/2024/pixel-upload.png", invert=true) }}

Last night I realized that my phone had started to backup 58 GB photos from my phone to Googles servers. **I had not requested this**. I'm fine to upload _some_ data to Google. I do for example have Gmail, files in Drive and a few shared albums in Google Photos. But that's completely different from blankly uploading **all** my photos! I do have privacy concerns, and of course 58 GB **will not fit** on my 17 GB quota.

{{ image(src="/images/2024/google-out-of-space.png", invert=true) }}

## Dark Design Patterns

Dark patterns, or deceptive design pattern is a user interface design pattern with the idea to trick users of doing things. Google has crafted the dialogs in the mobile application Google Photos to make it really easy to accidentally enable the backup feature. A dialog that is displayed regularly nagging the user to "please, enable backup" with no option to permanently decline. **I have been really careful to never agree to the offer**.

It's possible that I have accidentally clicked the button without realizing, but I have no memory of this. Both my girlfriend and mother accidentally enabled backup and filled up their Google accounts last year.

{{ image(src="/images/2024/google-pay.png", invert=true) }}

Googles recommended solution is to buy more space. It's cheap, easy and there is probably a lot of people that buy an upgrade. Paying is out of the question, **this behavior should never be rewarded**.

## Why the Google Photos app?

My phone is a Pixel, a phone from Google. I use the Pixel Camera app to take photos. It takes fantastic photos and Google Photos is the default image viewer, it's a great image viewer that supports all the special Pixel specific features. The combination of these three facts made it reasonable for me to to use the Google Photos app to browse my on-device photos.

## Revert, undo, abort

It's a little scarry to undo this. Google call the feature backup, but it's really more of a partial sync solution. When you remove an image from one device, it's automatically removed from all other devices as well.

So if I remove pictures via a web browser at `photos.google.com` the deletions _may_ be synced back to the phone. The trick is to turn off sync on the phone before you delete the pictures on the website. It's unclear what happens in the future if I accidentally re-enable the sync again? A little scarry.

{{ image(src="/images/2024/remove-files-photos.png", invert=true) }}

This do not create a warm and fuzzy feeling. I'm glad that I use a combination of [Syncthing](https://syncthing.net/) and [Immich](https://immich.app) so my images are safe there even if Google choose to nuke a few gigabytes of images on my phone randomly in the future. Nice backup feature Google.

## What now?

I have turned off backup/sync and I will remove all the images on `photos.google.com` like I did when I helped my mother last year. I hope that the deletions are not synced down to my phone, and I will monitor deletions if I need to restore anything from **my** backups.

{{ image(src="/images/2024/files-removed.png", invert=true) }}
