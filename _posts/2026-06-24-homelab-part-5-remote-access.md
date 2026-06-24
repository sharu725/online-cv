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
That last part is the whole reason I can sleep at night.

<figure>
  <img src="https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExZ2FqOHo0dGxidmtwejJ6YTl1anYxMmtnaWo5NDVlM2Jna213ZmYxaiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/NTur7XlVDUdqM/giphy.gif" alt="reaction gif" loading="lazy">
  <figcaption>The cluster, now reachable from a coffee shop.</figcaption>
</figure>

## Door one: dashboards from any browser

Sometimes I just want to pull up a web UI on whatever machine is in front of me,
with no client to install. For that I use a
[Cloudflare Tunnel](https://developers.cloudflare.com/cloudflare-one/connections/connect-networks/).

A small agent runs inside the cluster and dials out to Cloudflare, holding the
connection open from the inside. Nothing listens on the router, and the home
address stays hidden. That agent can reach both the in-cluster services and the
other boxes on the network, so there's no load balancer or port forwarding to
babysit.

The thing that got me: my home gateway quietly blocks the fast UDP protocol the
tunnel prefers, so it just would not connect, with no useful error to explain
why. I stared at it for an embarrassingly long time. The fix was forcing the
tunnel onto the older TCP path, and then it came right up.

<figure>
  <img src="https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExOHFuOXp0cXkxNThlZWt4bGhiaGl4N2VvdWE2NG9weHNvYjFvZDhjaiZlcD12MV9naWZzX3NlYXJjaCZjdD1n/pUeXcg80cO8I8/giphy.gif" alt="reaction gif" loading="lazy">
  <figcaption>Me, watching the tunnel fail with no error message.</figcaption>
</figure>

## The guard

Public access is only fine if something checks who you are. So the tunnel sits
behind [Cloudflare Access](https://developers.cloudflare.com/cloudflare-one/policies/access/),
which authenticates you at the edge, before any traffic reaches the cluster: an
email code, or a real identity provider. Think of it as a bouncer who works the
door before anyone even reaches the building.

One honest caveat: Access only gets you to the door. The apps still have their own
login behind it, so for now I get carded twice. Making one login cover everything
means wiring each app to an identity provider, which is Authentik, and that's a
job for later.

## Door two: the command line

Browsers are for looking. For actually running things (kubectl, the Talos API), a
public URL is the wrong tool. I'd rather the cluster trust the device than check a
password.

So every node joins a private mesh with [Tailscale](https://tailscale.com/), and
my laptop is on the same mesh. The command line works from anywhere, like the
cluster is sitting on the desk next to me, and none of it is exposed to the public
internet.

This one cost me an afternoon and a few words I won't print: the cluster's API
refused to trust the mesh until I added the nodes' mesh addresses to its
certificate. Until then, every connection got politely rejected. Add the
addresses, regenerate the cert, and suddenly we're friends.

<figure>
  <img src="https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExcmc5eXE0am1qYmRlOGs1ZW51MnpuMW9rdGtjN292bnhpeWpiZjl0bSZlcD12MV9naWZzX3NlYXJjaCZjdD1n/hFROvOhBPQVRm/giphy.gif" alt="reaction gif" loading="lazy">
  <figcaption>kubectl over the tailnet, finally.</figcaption>
</figure>

## Two doors, on purpose

The public browser door is for the quick "let me just check it" moments. The
private mesh door is for real admin work. Different trust, different jobs, and
neither one opens a hole in the home router, which was the whole point.

## What's next

Right now the guard and the apps each ask for a login, so I sign in twice like
it's 2009. Next up is making them agree: single sign-on with Authentik, so it's
one face at the gate instead of two.
