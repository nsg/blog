+++
date = "2024-07-30T21:00:00+02:00"
title = "The pain w/ E-mail"
[taxonomies]
tags = ["email", "reflections", "spam", "self-hosted", "federated"]
+++

I love distributed and federated systems. E-mail must be the biggest one out there, and it's also one that almost everybody uses. Everybody has an email, right?

I remember running Google Talk chatting with my Facebook friends 15 or so years ago. That worked because both chat systems supported federation. This was later shut down because the cooperations realized that there was more money in lock-in, keep your users in **your** walled garden.

E-mail is older than most cooperations, older than what you probably consider to be the internet. But that have not stopped the large cooperations to try to create a nice comfy walled garden for your e-mail. Everyone has to have an e-mail, right? That's a lot of users (money) to have.

## Most e-mails are spam

I have not checked if this is still true, but I have no reason to believe otherwise. There are a lot of spam out there. To much spam. E-mail was designed in a more innocent time, a time when there was mostly academics and scientists on the internet. [First spam](https://en.wikipedia.org/wiki/History_of_email_spam) was sent as marketing for a presentation and he got a lot of negative feedback for this unwanted message, and for some time that was it. Spam was solved. People know that this was not something you did, it was not nice. 

Of course, **most people** are nice, but there are always **some** that do not care if they can gain favour by exploiting a system. E-mails are free to send, so why not send 1000? 10 thousand or 100 million?

People built spam filters to try to combat the problem. But spammers tried to sneak thought them. Filters where improved. This has been going back and forth for 30 years.

Laws has been suggested and passed. Mostly by people that have no idea how to actually implement them. A lot of technical solutions have been suggested, and [some](https://en.wikipedia.org/wiki/DomainKeys_Identified_Mail) [implemented](https://en.wikipedia.org/wiki/DMARC). It's hard to retrofit a solution to massively federated system like e-mail, without breaking e-mail (to much).

## Everyone is using Gmail, right?

A spam prevention method that has been really popular (and effective) is network block lists. Back in the day, anyone at the internet could just send an e-mail from his or her computer. Just like that. Really awesome, but you understand why it was exploited.

Most residential networks where blocked to send e-mail. Few people needed that, did that, or even know they could. But there was a lot of malware that exploited home computers to send spam. This stopped that.

Left where the networks that real servers used. You know, servers that actually sent the ham (the opposite of spam). Spammers started to rent server to send spam and the people started to add them to block lists, first just single servers and later on entire providers network.

We are now in a situation where most people use e-mail from just a few large providers, like Gmail and Outlook. They have started to aggressively block anyone who is not one of the large ones. _For the greater good, to fight spam_. But, really, for the greater good to force anyone left to use them.

## It's hard to send

When I started running my e-mail server ten years ago it was still possible for me to deliver email to both Gmail and Outlook. I had to configure things properly. But when I had done so, my emails where delivered.

Then, Microsoft decided that Digital Ocean was bad. The entire thing. I was not able to send e-mails anymore to anything hosted at Microsoft servers. At first, it was rare that I needed to send e-mails to a Microsoft server, but have you noticed that Microsoft pushes hard for people to migrate to their cloud offering? Plenty of business have migrated to Microsoft servers. It has been really hard for me to e-mail a busies now for several years.

The problem is that providers like Microsoft do not really care for the few small e-mail servers out there. If they notice an increased amount of spams coming from a provider they just nuke the entire thing. Cutting of small business, forcing them in to one of the big providers.

> "We found you in the blocklist, no idea why you where there" - Large e-mail provider after they had blocked an entire server provider for months...

## I'm sad

I'm sad that e-mail, the largest and most successful federated communication technology is slowly dying and morphing. Do you remember when I wrote about how I chatted with my Facebook friends from Googles chat system? Give this e-mail mess another 10 years and maybe I can say the same thing about Gmail and Outlook? I hope not...
