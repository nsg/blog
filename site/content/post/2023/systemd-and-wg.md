+++
date = "2023-08-27T00:55:00+02:00"
title = "Systemd and WireGuard"
[taxonomies]
tags = ["systemd", "networkd", "systemd-networkd", "wg", "wireguard"]
+++

I'm moving a few servers around and I just realized that systemd-networkd supports WireGuard! This saves me from installing the wireguard tools packages, or any packages for that matter because systemd is already included.

## systemd-networkd

Systemd is an init system in it's core, but it's extendable with a lot of different components. For example systemd-journald is probably the most well known. Systemd-networkd is a component that manages the network in a systemd-fashion.

It's possible that you are missing systemd-networkd, it's for example common that desktop install uses NetworkManager instead.

## Configure

The configuration consists of three files. A `netdev` and a `network` file with systemd configuration, and a `key` file containing the private key.
The network configuration goes in `/etc/systemd/network/`, for simplicity I have also placed the key there.

### Server

Here is `wg0.netdev` and `wg0.network` respectively:

```ini
[NetDev]
Name=wg0
Kind=wireguard
Description=wg0 - wireguard tunnel

[WireGuard]
ListenPort=51820
PrivateKeyFile=/etc/systemd/network/wg0.key

[WireGuardPeer]
AllowedIPs=10.0.0.0/24
PublicKey=5yTjUiBhwTYBBJmiuvopREVJgHEkuQrunat+lu9k9iA=
```

```ini
[Match]
Name=wg0

[Network]
Address=10.0.0.1/24
IPMasquerade=both
```

... and that should do it! Make sure that `wg0.key` is owned by `root:systemd-network` with `640` permissions. See the [netdev documentation](https://www.freedesktop.org/software/systemd/man/systemd.netdev.html#%5BWireGuardPeer%5D%20Section%20Options) for more information.

The above example is configured as a server, it listens for incoming connections and has masquerading enabled. Below is the connecting client.

### Client

```ini
[NetDev]
Name=wg0
Kind=wireguard
Description=wg0 - wireguard tunnel

[WireGuard]
PrivateKeyFile=/etc/systemd/network/wg0.key

[WireGuardPeer]
PublicKey=9tREukFya+yVteb/wtkNsn1sXEvE/qZqe74A8CFWzww=
AllowedIPs=10.0.0.0/24
Endpoint=192.168.1.110:51820
```

```ini
[Match]
Name=wg0

[Network]
Address=10.0.0.2/24
```

That should do it! Execute `networkctl reload` to reload the configuration and inspect the journal for possible problems.
