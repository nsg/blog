+++
date = "2026-03-10T21:30:00+01:00"
title = "Blogger Helper"
[taxonomies]
tags = ["ai", "rust", "tools"]
+++

Since I had a kid a year ago, time has been rare and precious. I've been playing with [vibe coding](https://en.wikipedia.org/wiki/Vibe_coding) a lot. Yes, the results aren't always production ready, but I find it fascinating to use it to write simple tools for myself. One of these is a small tool I just call "Blogger," and it's exactly what it sounds like: a tool for blogging.

![](/images/2026/blogger-tool.png)

It's a rust binary that I can use like this `blogger  blog/site/content/post/2026/blogger-helper.md` and it will open the UI you see in the screenshot above.  It will spin up a podman container with my blog in the background and serve it in the first pane. The actual markdown file will be opened in the Monaco Editor (the editor component used by vscode) and finally an assistant chat window where I can chat and search the web.

The cool thing is that while I type it will automatically point things out, like for example I got the message below when writing the above text:

> The description of Monaco Editor as "(vscode editor)" is slightly misleading—Monaco Editor is the underlying editor component that powers VS Code, but it's not VS Code itself (it lacks extensions, terminal, debugging, etc.). Consider revising to "(the editor component that powers VS Code)" or simply "(Monaco Editor)" for accuracy. [Source: Monaco Editor GitHub README](https://github.com/Microsoft/monaco-editor/blob/main/README.md)

I find it valuable to have someone leaning over my shoulder, pointing out what's critical or nitpicky about what I'm writing. I've been thinking about returning to writing about various topics ([old man yells at cloud](https://knowyourmeme.com/editorials/guides/whats-the-old-man-yells-at-cloud-meme-how-the-simpsons-scene-became-a-viral-meme-explained)) and it feels nice to have something that points out when I'm too narrow-minded, or just misinformed. Will it catch everything? No. Half of it? Maybe. But that's enough to make it useful.

I have always enjoyed writing these small tools for myself. Sure, actually writing the code is half the fun and I have outsourced that to Claude at the moment, but the other half, to create and use something, is still there. To be honest, with my current limited time I would have no tool if I had to do it all myself.