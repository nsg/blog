+++
date = "2025-06-07T14:41:08+02:00"
title = "Immich Presentation"
[taxonomies]
tags = ["immich", "self hosted", "futo"]
+++

[FUTO](https://futo.org) the company that supports (funds the development of) the Open Source image management solution [Immich](https://immich.app) held a conference where its creator and a few developers discussed Immich. It was a good talk, and you can see it [here](https://www.youtube.com/watch?v=BrlOxXzs9Dg).

I have been a user of Immich for a little over two years now, and almost all that time I've been using my own package, or distribution, that I call [Immich Distribution](https://immich-distribution.nsg.cc). In short, I have replaced the Docker Compose-based setup with a single snap package.

![](/images/2025/immich-screenshot-2024.png)

My motivation was actually another snap that I have been using for many years, the [Nextcloud Snap](https://snapcraft.io/nextcloud). I love that updates are automatic and just happen in the background. I have had a few busy years with a lot of things going on in my life, and updating Nextcloud is something I don't need to worry about. Yet, I still enjoy all the advantages, such as control and privacy, that self-hosting offers me.

For me this has been a really great experience so I wanted to replicate the same with Immich. Immich released frequent updates, like several each week, when I started this project and I thought that maybe I could give that "Nextcloud Snap" experience to other people. I do have some experience with the package format, and it's always fun to tinker.

I had no idea how hard it would be, so I intentionally stayed somewhat quiet to limit the number of people finding the software. I preferred slow, natural, organic growth and not a huge spike anyway. If I discovered it to be too hard to maintain, it would not inconvenience many people. There have been a few close calls where I was stuck with annoying problems. With limited personal time, I even considered abandoning it to spend more time with my girlfriend, but things became easier as the project started to stabilize. Soon, they will release the first major stable version, and I hope it will be even easier to maintain from that point.

The repository has [43 stars](https://github.com/nsg/immich-distribution) which, for me, is a nice number, but of course nothing compared to the upstream project's [67.8 thousand stars](https://github.com/immich-app/immich). However, I have about a thousand happy users and I love to provide this service for them.

If you would like to try it, check out the [installation instructions](https://immich-distribution.nsg.cc/install/) and give it a go. If you rather prefer the more common, and by the upstream Immich project supported, installation option check out their official [Docker Compose](https://immich.app/docs/install/docker-compose) file, though some minor Docker knowledge is needed.

What about the future? Maintaining Immich Distribution has become easier with each passing year, and with the upcoming stable release, the project has promised more backward compatibility support. I have also created a lot of tooling around the release process. Currently, I see no reason not to continue this for many years to come.
