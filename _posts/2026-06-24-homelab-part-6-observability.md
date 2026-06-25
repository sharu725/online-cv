---
layout: post
title: "Homelab, Part 6: Watching It All"
date: 2026-06-24
tags: [homelab, kubernetes, observability, victoriametrics, storage]
---

[Part 5]({{ '/2026/06/24/homelab-part-5-remote-access.html' | relative_url }})
opened two doors into the cluster. Now I wanted to actually see what was going on
inside it: metrics, logs, network flows, a wall of graphs to stare at instead of
sleeping. This is where the homelab stops being a pile of YAML and starts telling
me how it feels.

## First, where does all this live?

Metrics and logs are just data, and data needs somewhere to sit. There are two
kinds here, and they want different homes.

Time-series metrics act like a small, busy database, so they want fast block
storage that survives a reboot. That's [Longhorn](https://longhorn.io/), which
keeps replicated block volumes spread across the worker nodes. A database that
loses its disk every time a node blinks isn't really a database.

Logs and traces are happier in object storage, the S3 kind. The obvious pick was
[MinIO](https://min.io/), except the free community edition has gone quiet: no
real releases in months, features trimmed out. I didn't feel like building on
something that already looks like it's coasting.

<figure>
  <img src="https://media.giphy.com/media/QMHoU66sBXqqLqYvGO/giphy.gif" alt="this is fine dog in a burning room" loading="lazy">
  <figcaption>MinIO's community edition, reportedly doing great.</figcaption>
</figure>

So I went with [Garage](https://garagehq.deuxfleurs.fr/) instead. It's small,
written in Rust, and copies objects across nodes by itself. That's also why I run
it on plain local disk instead of on Longhorn: Garage already makes its own
replicas, so layering it on top of Longhorn would just pay for the same safety
twice.

## The stack: VictoriaMetrics, not Prometheus

For metrics I went with [VictoriaMetrics](https://victoriametrics.com/) instead
of the usual Prometheus setup, mostly to save memory. Same query language, a
fraction of the RAM, and I only keep five days of history anyway. If I haven't
looked at a graph within five days, I'm not going to.

Logs go through [Loki](https://grafana.com/oss/loki/), with
[Grafana Alloy](https://grafana.com/oss/alloy-opentelemetry-collector/) as the
agent on every node. Alloy tails the pods, throws out the noise like health
checks and blank lines, keeps every error and warning, and samples the rest. I'd
rather not pay to store a million copies of `GET /healthz 200`.

The freebie I didn't expect: because the cluster runs [Cilium](https://cilium.io/),
its [Hubble](https://github.com/cilium/hubble) layer hands me network metrics for
almost nothing. There's no proxy stapled to every pod. Cilium already lives down
in the kernel's network path, so turning on metrics just exposes what it can
already see. One toggle and there were suddenly graphs of every connection, every
dropped packet, every DNS lookup in the cluster.

<figure>
  <img src="https://media.giphy.com/media/26ufdipQqU2lhNA4g/giphy.gif" alt="mind blown reaction" loading="lazy">
  <figcaption>Me, realizing the network data had been there all along.</figcaption>
</figure>

[Grafana](https://grafana.com/oss/grafana/) sits on top and ties it together,
behind the same single login from Part 5.

## What bit me

None of it worked first try, obviously. A few favorites.

### The missing agent

The node metrics exporter runs as a DaemonSet, so it should land one copy on
every node. Instead it landed on none. No pods, no crash, no error in any log,
just a count reading 0 of 7. Talos ships a strict pod security profile by
default, and that exporter wants host access the profile quietly denies. Nothing
says "I blocked this," the pods just never get created. The fix was one label on
the namespace.

<figure>
  <img src="https://media.giphy.com/media/hQKJwKAzq5NERlLf8L/giphy.gif" alt="confused math lady" loading="lazy">
  <figcaption>0 of 7 pods and not a single error. Cool. Cool cool cool.</figcaption>
</figure>

### The 63-character wall

One component refused to sync, grumbling that a name was too long. Kubernetes
caps certain names at 63 characters, and the chart had stacked its own name on
top of the one I gave it until the total tipped over. A shorter name override and
it stopped sulking.

### The volume tug-of-war

Grafana jammed halfway through a restart, the new copy waiting forever to come
up. Its disk only attaches to one node at a time, but the default rollout tries
to start the new copy before the old one lets go. Both wanted the same volume and
neither would blink. I told it to kill the old copy first, and the standoff
ended.

### The wrong door

A whole dashboard sat there reading "No data," and I nearly went crawling through
the scrape config hunting for the leak. The metrics were flowing the entire time.
I was just asking the wrong port for them. The service answers on one number, and
I'd spent a while knocking politely on the one next door.

<figure>
  <img src="https://media.giphy.com/media/HDQ26psL97H8K2qoUU/giphy.gif" alt="Picard facepalm" loading="lazy">
  <figcaption>It was the port. It's always something like the port.</figcaption>
</figure>

## While I was in there: Cloudflare as code

Part 5 set up the tunnel and its access rules by clicking around a dashboard,
which always leaves a small itch. So I pulled the whole thing into
[OpenTofu](https://opentofu.org/) and let code own it. The one rule when you adopt
live infrastructure: import, never recreate. Describe what already exists, nudge
the config until a plan shows zero changes, and only then trust it. Get that
wrong and you'll happily tear down the working tunnel you were trying to save.

## What's next

What I actually want out of all this: one login for everything, and a tidy page
of app tiles like a work SSO portal. That's [Authentik](https://goauthentik.io/),
and it's next.
