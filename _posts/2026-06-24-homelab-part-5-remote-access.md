---
layout: post
title: "Homelab, Part 5: Letting the Outside In"
date: 2026-06-24
tags: [homelab, cloudflare, tailscale, networking, security]
---

[Part 4]({{ '/2026/06/23/homelab-part-4-argocd.html' | relative_url }}) got the
cluster running itself, but it only lived on the home network. I wanted to check
it from the couch, from my phone, from a cafe on borrowed wifi. So I set up two
ways in, for two different jobs, and neither one opens a port on the home router.
That last part matters.

## Door one: dashboards from any browser

Sometimes I just want to pull up a web UI on whatever machine is in front of me,
with no client to install. For that I use a
[Cloudflare Tunnel](https://developers.cloudflare.com/cloudflare-one/connections/connect-networks/).

A small agent runs inside the cluster and dials out to Cloudflare, holding the
connection open from the inside. Nothing listens on the router, and the home
address stays hidden. That agent can reach both the in-cluster services and the
other boxes on the network, so there's no load balancer or port forwarding to
babysit.

The thing that tripped me up: my home gateway blocks the fast UDP protocol the
tunnel prefers, so it just wouldn't connect, and it took me a while to spot. The
fix was forcing the tunnel onto the older TCP path, and then it came right up.

## The guard

Public access is only fine if something checks who you are. So the tunnel sits
behind [Cloudflare Access](https://developers.cloudflare.com/cloudflare-one/policies/access/),
which authenticates you at the edge, before any traffic reaches the cluster: an
email code, or a real identity provider.

One honest caveat: Access only gets you to the door. The apps still have their own
login behind it. Making one login cover everything means wiring each app to an
identity provider, which is Authentik, and that's a job for later.

## Door two: the command line

Browsers are for looking. For actually running things (kubectl, the Talos API), a
public URL is the wrong tool. I'd rather the cluster trust the device than check a
password.

So every node joins a private mesh with [Tailscale](https://tailscale.com/), and
my laptop is on the same mesh. The command line works from anywhere, like the
cluster is sitting on the desk next to me, and none of it is exposed to the public
internet.

This one cost me an afternoon: the cluster's API wouldn't trust the mesh until I
added the nodes' mesh addresses to its certificate. Until then, every connection
from the mesh got rejected. Add the addresses, regenerate the cert, and it works.

## Two doors, on purpose

The public browser door is for the quick "let me just check it" moments. The
private mesh door is for real admin work. Different trust, different jobs, and
neither one opens a hole in the home router, which was the whole point.

## What's next

Right now the guard and the apps each ask for a login, so I end up signing in
twice. Next up is making them agree: single sign-on with Authentik, so it's one
face at the gate instead of two.
