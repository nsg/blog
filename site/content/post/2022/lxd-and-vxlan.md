+++
date = "2022-02-12T22:00:00+01:00"
title = "LXD and VXLAN"
[taxonomies]
tags = ["VPN", "Tunnel", "WG", "WireGuard", "VXLAN", "LXD"]
+++

## Let's start with a little background

I have a lot of servers all over the place, and it's not uncommon that I need to connect them together in some way. For simple setups [WireGuard](https://www.wireguard.com/) is working fantastically well but I usually need layer 2 networks. For that I still use [tinc](https://www.tinc-vpn.org/), another software I can recommend. Before WireGuard was a thing, tinc was easily my default choice.

## The new overlay

I use [LXD](https://linuxcontainers.org/lxd/) to run both VM:s and system containers on my servers and it supports VXLAN overlay networks. VXLAN has no encryption so I'm not going to send it over the internet. But we also have WireGuard, so let's combine them!

### Setup WireGuard

Just a quite vanilla WireGuard setup, no routing, NAT for forward needed. Just a point-to-point encrypted link. This is the content from the server that receives the connection.

```ini
[Interface]
Address = 10.0.1.1/24
SaveConfig = true
ListenPort = 1234
PrivateKey = secret-private-key1

[Peer]
PublicKey = peers-public-key2
AllowedIPs = 10.0.1.2/32
```

... and on the other server I have this:

```ini
[Interface]
Address = 10.0.1.2/24
SaveConfig = true
PrivateKey = secret-private-key2

[Peer]
PublicKey = peers-public-key1
AllowedIPs = 10.0.1.1/32
Endpoint = my-remote-server.example.com:1234
```

The content is placed in `/etc/wireguard/wg0.conf` on both servers. After than you need enable and start the configuration on both server and you should have a tunnel open.

```shell
systemctl enable wg-quick@wg0
systemctl start wg-quick@wg0
```

### Configure LXD

#### server1

Configure a new network bridge called _br-vxlan_, I disabled IPv6 because I do not need it. A ipv4 subnet will be allocated and shared via DHCP on this network.

```shell
lxc network create br-vxlan \
    tunnel.server2.protocol=vxlan \
    tunnel.server2.id=10 \
    tunnel.server2.local=10.0.1.1 \
    tunnel.server2.remote=10.0.1.2 \
    ipv6.address=none
```

Attach our new network to the default profile, name it _vxlan0_.

```shell
lxc network attach-profile br-vxlan default vxlan0
```

#### server2

This configuration is similar to the above. I disabled IPv4 because addresses will be provided via DHCP from server1. On this server I created a separate profile instead of placing the configuration inside the default profile.

```shell
lxc network create br-vxlan \
    tunnel.server1.protocol=vxlan \
    tunnel.server1.id=10 \
    tunnel.server1.local=10.0.1.2 \
    tunnel.server1.remote=10.0.1.1 \
    ipv4.address=none \
    ipv6.address=none

lxc profile create tunnel
lxc network attach-profile br-vxlan tunnel vxlan0
```

### Final notes

I will probably run my tinc tunnels for a long time. The new WG+VXLAN tunnels will be used to bridge a few new servers together, if it works well and stays stable I may start to replace tinc later on.
