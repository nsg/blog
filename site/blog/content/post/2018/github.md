+++
date = "2018-06-09T14:30:00+02:00"
title = "GitHub - The central spot for code"
tags = ["git", "github", "code", "microsoft"]
+++

The [acquisition of GitHub by Microsoft](https://blogs.microsoft.com/blog/2018/06/04/microsoft-github-empowering-developers/) brought up a few emotions and a few old thoughts of mine. GitHub had been the defacto community for code sharing for everything from FOSS projects to large businesses for some time now. Most people have an account, so you can expect people to be able to comment, make pull requests and so on. It is also large advantage to keep the code, issues and workflow at the same spot where the community is.

This is one of the things that I always have loved with GitHub, and I have placed all my FOSS software there. But a thought that always have annoyed me a little is the central importance of GitHub, the place all your eggs in one basked approach.

## Monoculture

This is never a good thing with just one dominant player controlling everything. Sure we have had smaller alternatives like [BitBucket](https://bitbucket.org/) and [GitLab](https://www.gitlab.com/) for some time but GitHub has dominated this space. GitHub has been the defacto place to be if you are not going to self host.

There is a lot of software projects that have built their ecosystem around GitHub, for example the [Snapcraft Build Services](https://snapcraft.io/) assumes that your code is hosted over at GitHub. The same is true with [Ansible Galaxy](https://galaxy.ansible.com/) and there are many many more examples of this.

This has been a large annoyance for me, and I'm using GitHub. I have no problem that these services integrates with the dominant platform, but please offer a way to use some other service. Preferably in a service neutral way, both my examples just really need a Git endpoint and a webhook to work.

## Diversity

You always hear the loud minority so it's hard to tell how many projects (and people) that actually moves away from GitHub after the news of Microsoft's acquisition. But if you for example look at this [blog post over at GitLab](https://about.gitlab.com/2018/06/03/movingtogitlab/) it looks like they are getting a lot of new users. We also have a [similar post over at BitBucket](https://blog.bitbucket.org/2018/06/04/10-reasons-teams-switching-github-bitbucket-microsoft-acquisition/).

So it looks like people are spreading out over GitLab, BitBucket and GitHub now. It's possible that it will stay like this, but it's even more likely that these three sites will be two dominant ones in 2-3 years. We usually see a single dominant one (GitHub from the past) or two giant fighting (Android/iOS, Windows/macOS). There is rarely room for a 3rd option.

Overall, it's good to see the monoculture breaking up. I hope it will work, and not kill the excellent community feeling that we have had at GitHub over the years.

## Where will people go?

Actually, I think an large portion of people will not. At the moment if you are not anti-Microsoft there is little reason to move. A large company backing the site, a company with a lot of money can be a really good thing. If they keep the GitHub spirit alive GitHub will continue being a excellent choice.

Over the last years Microsoft have changed from a company that only cared about it's self and their own technology, with a CEO that called Linux cancer, with a hyper focus around Windows, windows, window ... to what we have today, a nicer player that releases software and code for iOS, Linux and Android. At the moment it feels like they just like to make money, they do not care if the user runs Windows or Linux. Still, I understand that there is a lot of people that remembers the old Microsoft so plenty of people will move.

I think most of the FOSS users that move will go to GitLab, mainly because it has a less enterprise-y feeling, and that the core of GitLab is open source. With an even split for the rest between BitBucket and GitLab depending whatever system they prefer.

This will make GitLab and GitHub the two large communities in the coming years. Time will tell.

## An interesting twist with GitLab

An interesting thing with GitLab is it's open source core. All three offers enterprise on premise offerings, but GitLab also offers a free FOSS alternative that has all the core features of the hosted solution.

This makes it possible for me to use GitLab at, for example, git.nsg.cc instead of gitlab.com. I have control of all the code, with is exactly my type of solution. Just one problem, why would anyone bother to make an account on my installation just to submit an issue or to open an merge request? For a large project, sure, for a small project, most likely not.

Working federation will solve this, when it is possible to fork gitlab.com/project/repo to git.nsg.cc/nsg/repo, and then provide a merge request back and commit to issues, all with my identity from git.nsg.cc, them we are home! [There is some discussions of it over here](https://gitlab.com/gitlab-org/gitlab-ce/issues/4013).

## What will I do?

Time will tell, I think I will start to use my newly created GitLab.com account a little over the coming weeks, I have been using (and administrating) a self hosted solution at work for a few months now and I'm impressed! I will probably keep most of my repositories over at GitHub for now, I will stop paying and move my private repos to GitLab. If Microsoft destroys GitHub I will be ready to move to GitLab.
