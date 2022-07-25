+++
date = "2022-07-25T14:55:00+02:00"
title = "Easy Podman Systemd Service"
tags = ["podman", "systemd"]
+++

I have kept an eye at [Podman](https://podman.io/) since [Giuseppe](https://github.com/giuseppe) started to work on it, I have played with it from time to time and I have been impressed how the project has evolved. Since Ubuntu 22.04 LTS, Podman is finally part of the normal Ubuntu repos so I'm in progress of replacing all my Docker usage to Podman and from time to time I find a few quite awesome small tools, like this one:

## Launch a container like you normally do

```
# podman create --name nginx nginx:latest
```

`run` works to, it will **not** confuse the next step.

## Make a systemd unit file

```
# podman generate systemd nginx > /etc/systemd/system/podman-nginx.service
# systemctl enable podman-nginx.service
# systemctl start podman-nginx.service
```

... and we have a unit file created to start/stop the container. Awesome! If you like to tweak it there are a few options, personally I like `--name` to use the name instead of the container hash, and possible `--new` if you like to start with a fresh container each time.

Check out [the manpage](https://docs.podman.io/en/latest/markdown/podman-generate-systemd.1.html) for more information, and oh, there is a [generate kube](https://docs.podman.io/en/latest/markdown/podman-generate-kube.1.html) as well.
