+++
date = "2024-07-30T22:50:00+02:00"
title = "Uses of AI"
[taxonomies]
tags = ["AI", "ChatGPT", "LLM", "GPT"]
+++

Yeah, I agree that there is an AI hype going on. I agree that there is a lot of overlap with the cryptocoin hype. I also wish that people stopped to shoehorn in AI to everything. I wished we never called it AI because it's not intelligent. But here we are.

I find the technology fascinating, and I love to see real problems being solved with it. I love to play with AI of every kind and I write some software using it. It's hardly the magic unicorn dust that some companies love to tell you, but there are uses. Let me illustrate a really simple example with this blog post.

## Tag processing

About fifteen years ago I wrote a custom written [tag plugin](@/post/2006/bloggarse.md) for my blog. I wrote a small plugin that parsed the blog and generated inline tags that where picked up by a [blogging aggregator](http://www.knuff.se/) and [tagging service](http://www.bloggar.se) that was popular in Sweden back then.

The tags where useful data left there in old posts. They looked like below, and there was 186 different posts with them. Several hundreds of useful tags left unused for 15 years.

```
:: tag1, tag2
```

I have since then migrated between blogging platforms several times. It's not like it's hard for me to write a little script to parse this and import the tags. But there is a little friction, and this is not important. I have not bothered to do this... for years. I find AI useful for these cases. I know I can do it my self, I just can't bother. Please use some of the magical fairy dust to solve the problem for me.

### Let's ask ChatGPT

I opened a chat window and wrote this prompt. I usually finds it useful to be specific and give it samples for best results. It's also easier to just copy and paste an example instead of trying to explain what I need.

> Write me a small python program that will do this:
> 
> Scan the folder structure in `site/content` and look for files containing the pattern `:: tag1, tag2` and so on. Basically a comma separated list with a :: at the start of the line.
> 
> If the file contains this pattern, update the front matter. It's a code written between two +++ like the example below:
> ```
> +++
> date = "2007-11-01T11:31:52+00:00"
> title = "Nya Gmail"
> +++
> ```
> I like you to insert the found tags in that like this:
> ```
> +++
> date = "2007-11-01T11:31:52+00:00"
> title = "Nya Gmail"
> tags = ["tag1", "tag2"]
> +++
> ```

This created a small python script for me, but I realized that I forgot to remove the old tag format so I added

> Also, please remove the line with the ::

It provided me with an updated script. I did quick sanity check and executed it and it did exactly what I had asked it to do. Of course, I'm only human so I realized that I had provided the incorrect syntax, so I updated the chat with:

> Oh, I forgot. Please add [taxonomies] above the tags section. And please make all tags lowercase

I also took the chance to make everything lowercase. And here is the final script:

```python
import os
import re

def update_front_matter(file_path, tags):
    with open(file_path, 'r') as file:
        content = file.read()
    
    front_matter_match = re.search(r'\+\+\+\n(.*?)\n\+\+\+', content, re.DOTALL)
    if not front_matter_match:
        return
    
    front_matter = front_matter_match.group(1)
    new_front_matter = f'{front_matter}\n[taxonomies]\ntags = {tags}\n'
    updated_content = content.replace(front_matter, new_front_matter)
    
    updated_content = re.sub(r'^::.*$', '', updated_content, flags=re.MULTILINE)

    with open(file_path, 'w') as file:
        file.write(updated_content)

def scan_and_update_tags(directory):
    tag_pattern = re.compile(r'^::\s*(.*)$', re.MULTILINE)
    
    for root, _, files in os.walk(directory):
        for file in files:
            file_path = os.path.join(root, file)
            with open(file_path, 'r') as f:
                content = f.read()
            
            tag_match = tag_pattern.search(content)
            if tag_match:
                tags = [tag.strip().lower() for tag in tag_match.group(1).split(',')]
                tags_str = str(tags).replace("'", '"')
                update_front_matter(file_path, tags_str)

scan_and_update_tags('site/content')
```

I did a single change to the script, I removed a `\n`, a stylistic choice that I preferred. And I ended up with 186 of these changes:

```diff
diff --git a/site/content/post/2006/akismet.md b/site/content/post/2006/akismet.md
index 53b7ed7..00b2c20 100644
--- a/site/content/post/2006/akismet.md
+++ b/site/content/post/2006/akismet.md
@@ -1,13 +1,15 @@
 +++
 date = "2006-06-14T22:41:05+00:00"
 title = "Akismet"
+[taxonomies]
+tags = ["akismet", "spam"]
 +++
 
 > Akismet has protected your site from 88 spam comments.
 
 Jag är riktigt glad att jag valde att installera [Akismet][1] innan stormen kom.
 
-:: Akismet, spam
+
 
 <small></small>
```

## Did this save time?

Yes, the dialog about took be around 2 minutes. There are no way that I would be able to reproduce the code, or even a more hack-y version of the code in that time. But the most important aspect it that it did it. I have ignored this small chore for 15 years and now it was really easy and fun to fix it. So I did.
