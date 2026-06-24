---
layout: post
title: "Homelab, Part 5: Letting the Outside In"
date: 2026-06-24
tags: [homelab, cloudflare, tailscale, networking, security]
---

[Part 4]({{ '/2026/06/23/homelab-part-4-argocd.html' | relative_url }}) got the
cluster running itself. Good. But it only lived on the home network. Grug want to
check cluster from couch. From phone. From cafe with borrowed wifi. Home network
say no.

So I built two doors, for two different jobs. Neither one opens a port on the
home router. That part matters.

## Door one: see the dashboards from any browser

Sometimes I just want to open a web UI on whatever machine is in front of me. No
client to install, no VPN. For that I use a
[Cloudflare Tunnel](https://developers.cloudflare.com/cloudflare-one/connections/connect-networks/).

A small agent runs inside the cluster. It dials out to Cloudflare and holds the
door open from the inside. Nothing listens on the router. The home address stays
hidden. That agent can reach both the in-cluster services and the other boxes on
the network, so there is no load balancer and no port forwarding to babysit.

One fight with the cave: my home gateway blocks the fast protocol the tunnel
wants (the UDP one). Tunnel just refused to connect. Stared at it for a while,
confused. The fix was to force the tunnel onto the older TCP path. Then it
worked. Router happy, grug happy.

## The guard at the door

Public is fine only if someone checks faces. So the tunnel sits behind
[Cloudflare Access](https://developers.cloudflare.com/cloudflare-one/policies/access/).
Access decides who you are at the edge, before any traffic reaches the cluster:
an email code, or a real identity provider.

Honest bit: Access only gets you to the door. The apps still have their own login
behind it. One login for everything means wiring each app to an identity
provider. That is [Authentik](https://goauthentik.io/), and that is a job for
later.

## Door two: drive the cluster from the command line

Browsers are for looking. For actually running things, a public URL is the wrong
tool. I want the machine to trust the device, not just check a password.

So every node joins a private mesh with
[Tailscale](https://tailscale.com/), and my laptop joins the same mesh. Now the
command line works from anywhere, like the cluster is on the desk next to me, and
none of it touches the public internet.

One trap cost real time: the cluster's API would not trust the mesh until I added
the nodes' mesh addresses to its certificate. Before that, every connection from
the mesh got rejected. Add the addresses, regenerate the cert, done.

## Two doors, on purpose

Public browser door for the quick "let me just check it" moments. Private mesh
door for the real admin work. Different trust, different jobs. Neither one opens a
hole in the home router, which was the whole point.

## Next

Right now the outer guard and the apps each ask for a login, so I sign in twice.
The next job is making them agree: one sign-on with Authentik, so it is one face
at the gate instead of two.
