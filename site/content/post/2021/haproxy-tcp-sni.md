+++
date = "2021-04-30T13:37:00+02:00"
title = "HAProxy TCP forward with SNI"
[taxonomies]
tags = ["haproxy", "kubernetes", "k8s"]
+++

For a long time I have been running most of my HTTP traffic via a HAproxy installation. This will grant me great flexibility with a stable frontend, and I'm then free to route different parts of to whatever backend I need to solve my task.

![HAproxy diagram](/images/2021/haproxy-diagram.png)

## Kubernetes

I added a Kubernets cluster earlier this year, in it's first iteration it exposed an Ingress with a self signed TLS certificate that the HAproxy just reverse proxied like any other site, like this:

```
frontend https
    bind *:443 ssl strict-sni crt "$CERTS" alpn h2,http/1.1
    mode http
    option forwardfor
    option httplog

    use_backend be_kube_https if { hdr_end(host) -i kube.example.com }

backend be_kube_https
    server kube-1 10.0.0.1:443 maxconn 128 ssl verify none check
    server kube-2 10.0.0.2:443 maxconn 128 ssl verify none check
    server kube-3 10.0.0.3:443 maxconn 128 ssl verify none check
```

### First iteration

This worked, and I [moved this blog](/post/2021/k8s/) over to this solution back in January. This is of course clunky and not the best for several reasons:

#### Performance

The traffic is decrypted in the frontend and then once again encrypted in the backend. I do not do any URL inspections, rewrites or really anything useful for this kind of traffic so this is really just an extra step that adds nothing of value.

#### Security

This is hardly end-to-end encryption. HAproxy have access to the plain text message. The backend traffic was send over unverified TLS, but that connection is secured by other means.

#### HAproxy needs to manage the certificates

This can be an advantage if the backend can't or won't manage their own certificates. For me, in Kubernetes I preferred to keep to do everything inside the cluster.

## Second iteration

I could not just forward all traffic on port `443` in `mode tcp` to my new kube backend, I have plenty of services outside Kubernetes and I need to keep compatibility with the old pattern. I ended up with this:

```
frontend tcp443
    bind *:443
    mode tcp
    option tcplog
    tcp-request inspect-delay 2s
    tcp-request content accept if { req_ssl_hello_type 1 }

    use_backend be_kube if { req_ssl_sni -m end .kube.example.com }
    default_backend tcp443tohttps

frontend https
    bind 127.0.0.1:443 accept-proxy ssl strict-sni crt "$CERTS" alpn h2,http/1.1
    mode http
    option forwardfor
    option httplog

    use_backend be_kube_https if { hdr(host) -i nsg.cc }

backend tcp443tohttps
  mode tcp
  server https 127.0.0.1:443 send-proxy-v2-ssl-cn

backend be_kube
  mode tcp
  server kube-1 10.0.0.1:443 maxconn 128 check
  server kube-2 10.0.0.2:443 maxconn 128 check
  server kube-3 10.0.0.3:443 maxconn 128 check

backend be_kube_https
    server kube-1 10.0.0.1:443 maxconn 128 ssl verify none check
    server kube-2 10.0.0.2:443 maxconn 128 ssl verify none check
    server kube-3 10.0.0.3:443 maxconn 128 ssl verify none check
```

Traffic enters in the frontend `tcp443` in TCP mode. The SNI header is inspected and all traffic matching `*.kube.example.com` is sent to my Kubernetes cluster in TCP mode. All other traffic is routed in to the old frontend via the default backend. In the example above, the traffic for this blog is still routed via the old path in to the cluster.

![HAproxy diagram 2](/images/2021/haproxy-diagram-2.png)

## Let's Encrypt

This works, just a tiny bit. I need to forward the ACME well-known urls down to Kubernetes so I could issue certificates with [cert-manager](https://cert-manager.io/) from the cluster without caring that there is a layer of proxy between me and the internet.

I added two ACL:s to my http frontend (that listens in port 80 in http mode, not shown until now) with the following content. This frontend is mostly otherwise used to send redirects to https.

```
acl acme-challenge path_beg /.well-known/acme-challenge/
acl kube hdr_end(host) -i .kube.example.com

use_backend letsencrypt-backend-kube if acme-challenge kube
use_backend letsencrypt-backend if acme-challenge
```

`letsencrypt-backend-kube` will just route the traffic down to the cluster on port 80, nothing special. `letsencrypt-backend` is used for the HAproxys own certificate management and is out of scope for this blog post.

Renewals will occur over TLS, the ACME challenges for traffic sent to Kubernetes should already be sent to the cluster, and for default backend, I just added a ACL similar to the one above. All done!
