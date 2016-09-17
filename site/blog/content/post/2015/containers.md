+++
date = "2015-01-07T16:01:00+01:00"
title = "Containers"
tags = ["Docker", "Containers"]
+++

One thing that has become really interesting over the last year is [Docker](https://www.docker.com/). It has evolved quickly and built up an ecosystem with a really active community. At work, we started to migrate from a old monolithic infrastructure to a service based infrastructure. We are deploying a mix of different platforms and tools and are trying to keep us independent of specific tools, we think it is too early to see who is the winners, and what platform or project that still will be around in five years.

We have made two assumptions, containers and Linux, and I can almost guarantee you that this will area will continue to grow. At the moment we are using a mix of [Heroku](https://www.heroku.com/) and a inhouse system built around [Helios](https://github.com/spotify/helios) (+ [Consul](https://consul.io/), [Nginx](http://nginx.org/), [HAProxy](http://www.haproxy.org/), ...). We choose not to use platforms like [CoreOS](https://coreos.com/), [Kubernetes](https://github.com/googlecloudplatform/kubernetes), ... because it didn’t feel like the right fit back then. Helios on the other hand was easy to install on the existing infrastructure.

Will we still use this in a year or two? Unlikely, we are hoping that the winners will present themselves and that we can purchase a off the shelf product with support. Preferably with a open source codebase.

Who are the winners? That’s hard to tell, but two projects that I like to keep an eye on are [Project Atomic](http://www.projectatomic.io/) (who is backed by Red Hat), and CoreOS. Both are big business oriented and I’m sure we will see interesting things. I’m sure that VMware will be big as well, they have an excellent connection with big companies today on the VM space and will most likely be able to extend that with a container based solution.
