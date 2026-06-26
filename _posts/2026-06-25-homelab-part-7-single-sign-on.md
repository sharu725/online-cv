---
layout: post
title: "Homelab, Part 7: One Login for All of It"
date: 2026-06-25
tags: [homelab, kubernetes, authentik, sso, cloudflare]
---

[Part 6]({{ '/2026/06/24/homelab-part-6-observability.html' | relative_url }})
gave me a wall of graphs. Useful, but it also rubbed in a problem I'd been
ignoring: every app in the cluster had its own login. Grafana, ArgoCD, the
Proxmox boxes, soon a pile of others. A different password prompt each time, or
worse, the same password everywhere. I wanted what work has: one login, and a
single page of tiles to launch everything from.

That turned into two pieces. A dashboard to look at, and an identity provider
behind it to do the actual logging in.

## The easy half: a dashboard

The launcher was the quick win. I went with [Homepage](https://gethomepage.dev/),
which keeps its whole config in plain YAML files in the repo. That mattered more
to me than looks. The popular alternative, Homarr, stores everything in a
database you click together in a browser, which fights the way the rest of this
homelab works: everything is a file in git, applied by
[ArgoCD](https://argo-cd.readthedocs.io/). Homepage just reads config I commit,
so it fits right in.

A handful of tiles later (ArgoCD, the Proxmox nodes, Grafana, and the new login
portal), plus a small widget showing each node's CPU and memory, and I had a
front page for the whole house.

<figure>
  <img src="https://media.giphy.com/media/2QSvHa1pqlcmBOeI77/giphy.gif" alt="woman doing a chef's kiss with MAGNIFICENT caption" loading="lazy">
  <figcaption>One page, every box. Should have done this months ago.</figcaption>
</figure>

## The hard half: actual single sign-on

A page of links is not single sign-on, though. Clicking a tile still drops you
at that app's own login. For one real login across everything I needed an
identity provider, and I went with [Authentik](https://goauthentik.io/).

Authentik wants a real database, so it got one: a Postgres cluster managed by
[CloudNativePG](https://cloudnative-pg.io/), the operator that treats a database
as something Kubernetes looks after, failover and all, instead of a pet I
hand-feed. I skipped the database the Authentik chart bundles on purpose. It
ships a vendor image that went legacy last year, and I don't want to build on
something already rotting. Redis tagged along too, the small throwaway kind,
just a cache.

## Wiring it to the front door

Here's the part I actually enjoyed. Since Part 5, everything reaches the outside
world through [Cloudflare Access](https://developers.cloudflare.com/cloudflare-one/policies/access/),
which until now logged me in by emailing a one-time code. Instead of ripping
that out, I taught it to also offer Authentik as a login option. Visit the
dashboard now and Cloudflare shows a chooser: sign in with Authentik, or get a
code by email.

That second option staying put is deliberate, and it's the whole trick.

<figure>
  <img src="https://media.giphy.com/media/LRVnPYqM8DLag/giphy.gif" alt="Jordan Peele sweating nervously" loading="lazy">
  <figcaption>Authentik is down and it's the only way in. Start sweating.</figcaption>
</figure>

If I made Authentik the only way in, then the day it breaks I'm locked out of
ArgoCD, which is the exact tool I'd use to fix Authentik. So the rule I'm
keeping: never put the thing that repairs your login behind your login. The
admin tools keep the email-code door as break-glass. The convenience apps can
hide behind Authentik all they like.

## What bit me

It was not smooth. A few favorites.

### The read-only dashboard

Homepage came up and returned an error on every single page. The logs showed it
trying to create a folder for its own logs and failing. I'd mounted its config
straight from the file in git, which makes that folder read-only, and the app
wants to write there on boot. The fix was to copy the config into a writable
scratch space at startup instead of mounting it frozen.

### The graphs with no numbers

The node CPU and memory widget just said "API Error." It turns out Homepage asks
the cluster for live usage numbers, and nothing in mine was producing them.
[Talos](https://www.talos.dev/) doesn't ship the little component that does
([metrics-server](https://github.com/kubernetes-sigs/metrics-server)), and when
you add it by hand it needs one extra flag to trust Talos's self-signed internal
certificates. One flag, and the bars filled in.

<figure>
  <img src="https://media.giphy.com/media/oaXRLIMnkGBnuQOBzE/giphy.gif" alt="thousand yard stare" loading="lazy">
  <figcaption>Reading scrape configs for an hour when the answer was "install the thing that makes the numbers."</figcaption>
</figure>

### The logo that wasn't

A small one. The ArgoCD tile showed a broken image while every other icon
loaded. The icon set calls it argo-cd, and I'd written argocd. One hyphen.

<figure>
  <img src="https://media.giphy.com/media/3xz2BLBOt13X9AgjEA/giphy.gif" alt="Batman facepalm" loading="lazy">
  <figcaption>An hour of my life, one missing hyphen.</figcaption>
</figure>

### The DNS that lied

The dashboard refused to load with a name-not-found error, while every tool I
checked swore the name resolved fine. The record was new, and I'd visited the
address a few times before it existed, so the browser had cached the "doesn't
exist" answer. Clearing that cache, not the actual DNS, was the fix.

## How much backup is enough?

Once real logins depended on Authentik, a single database pod felt nervous. If
its node rebooted mid-update, nobody logs in. So I gave it a standby: two
database instances, one leading and one following, with automatic promotion if
the leader falls over.

I almost reached for three. But CloudNativePG doesn't need a third for a clean
handoff. It leans on Kubernetes itself to decide who leads, so there's no tie to
break, and a third instance is really just a spare for the spare. For a home
setup that's a pod and a disk I don't need. Two is the honest amount of paranoia
here.

## What's next

The tiles still drop you at each app's own login for now. The next round is
teaching the apps themselves, Grafana and ArgoCD, to trust Authentik directly,
so one login truly carries everywhere. The fix-it tools keep their break-glass
door. That's the next post.
