+++
date = "2022-12-27T22:20:00+01:00"
title = "Migrate to Zola with a new design"
[taxonomies]
tags = ["zola", "blog"]
+++

I had some time to thinker with the blog over the last days. There has been a lot of interesting things invented since I last looked deeper at CSS, like flex and grid layouts,  animations. Yeah, I have been out of the loop since forever.

I have had the current theme [since 2017](@/post/2017/new-theme.md), that's five years. I picked the old one because I wanted something clean with focus on the content. This was the second iteration of [the hugo based blog](@/post/2016/hugo.md) that I have been running since 2016.

I have been using [Zola](https://www.getzola.org) on another site and I find it really nice to use. It's made by a old Hugo user so it's quite similar. Different language, frameworks and template engines ... but still they are really similar and easy to understand. Maybe not a huge improvement compared with Hugo but it's a fun thing to do, so let's port this site over to Zola!

## The old design

![](/images/2022/migrate-zola-old-hugo-design.png)

The old design is based on [blackburn](https://github.com/yoshiharuyamashita/blackburn). It's a simple design with monochromic colors and an out of the way design with a focus on the text. I did not write this and I never understood Hugo templates that deep so I had only done minor adjusments.

I actually started writing this blog post in Hugo, and now I finish it under Zola. Zola actually renders the markdown unmodified from Hugo, just a few minor adjustments where needed for full functionality like tags. The sharp eyed notice that I have rewritten some of the text, feel free to read the screenshots if you like to read the first draft of this post.

![](/images/2022/migrate-zola-old-hugo-design-index.png)

I also liked the yearly list of posts showing off the blogs age with posts going back all the way to 2005. I will probably try to keep some of these aspects in the new blogs design.

## Zola & the new design

The entire site it written from scratch, HTML, CSS, JS and Zola Templates (Tera). I tried to replicate the pattern from Hugo that I liked, I also took the time to improve a few things when I changes things anyway.

![](/images/2022/migrate-zola-new-design-draft.png)

It felt like a good idea to start with light and dark mode. I have never written this before so I ended up with a non-optimal solution that needs to be improved later.

I picked the color scheme that the old site used. The site is centered with a much larger font size with a lot of space between the elements. The screenshot above is the first page after my first coding session.

![](/images/2022/migrate-zola-new-design-index.png)

With a lot of inspiration from the old site I continued to implement the first page. A new thing that I wrote is image thumbnails. They are also gray scale like the rest of the site.

![](/images/2022/migrate-zola-new-design-archive.png)

I replicated the clean feeling of "just a list of posts" under the archive section. Just a simple formatted list with dates. I used the same type of layout for the "all tags" page.

![](/images/2022/migrate-zola-new-design-swedish.png)

I also added a nice little message telling visitors that posts before this point in time is written in Swedish. One of the nice things by having full understanding of the template language.

I have also added a lot of minor adjustments like a warning message that shows on old blog posts that the information may be out of date. I also added a search function to the site, Zola can generate a search index for [Elasticlunr](http://elasticlunr.com/) that I then can write some JS for.

There are some minor tweaks and adjustments I need to make. I will now declare victory and say "good enough" and release this new design to the world!

See you!
