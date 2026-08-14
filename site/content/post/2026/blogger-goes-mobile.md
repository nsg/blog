+++
date = 2026-08-13
title = "Blogger goes mobile"

[taxonomies]
tags = ["ai", "tools", "personal", "ai-scribed"]
+++
A while ago I wrote about [Blogger](/post/2026/blogger-helper/), a little tool I vibe coded to help me write posts like these. Since then I have kept tinkering with it, and it has changed quite a bit.

This blog has been around for over twenty years, I started it back in 2005. In the beginning I posted often, several times a week. Scroll through the archive and you will notice that the posts get further and further apart. Some years there is only one or two. The reason is simple, I have prioritized other things. And the urge to write has always tended to strike when I'm out and about, not sitting in front of the keyboard.

This is not the first time I have tried. A while back I put together a [hacky little script](/post/2025/hacky-simple-hack/) to blog from my phone through Obsidian and Syncthing, held together with tape. My second try was Blogger, and this time I did it properly, and made Blogger mobile friendly. On narrow screens it hides some of the panes and adapts the layout, so I can actually write from my phone. I also made it a [PWA](https://en.wikipedia.org/wiki/Progressive_web_app), so I can install it and it feels like a proper app instead of just a web page.

## Turning it into a server

Once it worked on the phone, I wanted to push it a bit further into something with CMS-like features. Not a full CMS, just the narrow subset I actually need. The point was to keep the same publishing pattern and the same static backend I already had. The funny thing was that I already had most of the architecture sitting inside the [Blogger](https://github.com/nsg/blogger) project.

I replaced the CLI based interface with a proper server, and changed the configuration to run better in a cloud native setting. The binary is argumentless now, it just starts as a server, and it is configured through environment variables. It fits nicely inside a Kubernetes deployment, a Docker Compose file, or a plain systemd service.

It serves the same UI I already had, with a few things on top. There is a file picker now, a list of all my posts sorted by year and month. I click one and it opens in the editor with the live preview, just like before. I also added a Git commit button that commits the current state and pushes it, with a simple message generated from what changed.

I put it on a server here at home. So now I have a page I can browse from my computer or my phone that gives me the experience I wanted. I can browse my posts, browse my drafts, and publish them. And publishing really just means pushing to Git.

## Talking my way to a post

The last feature, and the one I'm using right now, is an [MCP](https://modelcontextprotocol.io/) server. It exposes a handful of Blogger's capabilities to an AI agent, like creating and editing drafts, appending to them, and searching through my old posts.

Which means I can write a post just by talking. This one was drafted that way, I chatted with an agent out loud while it searched my archive to get a feel for how I write, and edited the draft as we went.

Back in [Reflections and Avatars](/post/2025/reflections-and-avatars/) I tried something similar and came away a little unsure. I really do love to write, to take my time and think about the words, and doing it this way takes some of that enjoyment away. That is still true. If I have the time, I would rather sit down at the keyboard.

But here is the thing I have made peace with. When I don't have the time, the alternative is not writing it by hand later. The alternative is not writing at all. And I would much rather have this than nothing.
