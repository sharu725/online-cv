---
layout: post
title: "Homelab, Part 1: Setting Up the Hardware"
date: 2026-06-21
tags: [homelab, infrastructure, proxmox, kubernetes]
---

First post in a series on building out my homelab. The goal is to run the same
kind of infrastructure I work on (Kubernetes, GitOps, observability) without
paying a cloud bill for every experiment. Part 1 is the hardware.

## How it started

I ran a homelab on a couple of Raspberry Pis for a while. They were great for
poking at things: small, cheap, low power, and hard to break in any permanent
way.

Then I wanted to run models locally with Ollama, and the Pis ran out of room
fast. Fine for tinkering, not for anything memory hungry. I wanted a real
multi-node setup I could run a proper Kubernetes cluster on, and host local LLMs
without paying per token.

So I went shopping, secondhand and cheap. That budget is the whole reason this is
mini PCs and a few small boxes instead of a loud rack server.

## The hardware

Four small machines, a switch, and a NAS. Nothing rack mounted.

### Compute: 2x Dell OptiPlex 3070 Micro

The two workhorses, plex1 and plex2. They're identical:

| Component | Spec (per node) |
|---|---|
| CPU | Intel Core i5-8500T (6 cores, 35 W) |
| RAM | 24 GB |
| Boot disk | ~256 GB NVMe |
| Data disk | 2 TB SSD |
| Hypervisor | Proxmox VE 9 |

A 35 W CPU sips power and stays quiet, but six cores and 24 GB are plenty for a
few VMs, with enough headroom left for Ollama. I picked two boxes instead of one
bigger one on purpose, so I could split the cluster across machines and actually
learn how multi-node setups behave.

### 2x Raspberry Pi 5

The Pis are still here, and they're not just tinkering boxes anymore. Both run
Talos Linux as full members of the Kubernetes cluster (Part 3 covers that). One
is a third control-plane node, the tie-breaker that gives etcd an odd-numbered
quorum. The other is an arm64 worker. A Pi makes a good tie-breaker: low power,
and unlike a laptop it comes back on by itself after an outage.

### Storage: Buffalo TeraStation 5200 NVR

Bulk storage and backups live on a secondhand Buffalo TeraStation, a 2-bay box
with two 4 TB drives. It has gigabit networking, so the box itself isn't the
limit, but it's slower than the local SSDs, so it stays in the backups tier.
Anything that needs to be quick lives on the node-local SSDs instead.

### Networking: TP-Link switch

Everything sits on one flat LAN:

```
                Internet
                   |
            home router   (gateway, DHCP)
                   |
            TP-Link switch  (unmanaged, 5 V)
        |       |        |        |       |
      plex1   plex2   Buffalo    rpi5    rpi5
                       NAS
```

It's a plain unmanaged 5 V TP-Link unit, the same low-power class as the Pis. No
VLANs, nothing fancy. The OptiPlex boxes each have one gigabit NIC, and the
switch just ties everything together off the router. VLANs are on the list for a
later post.

### Power

Low power by design, since those 35 W CPUs idle quietly. No UPS yet. That's the
next buy, because a power blip is the one thing this setup can't ride out right
now.

## What's running on it

The Kubernetes cluster runs as VMs on the two Proxmox nodes, plus the two Pis.
The Proxmox side:

| VM | Role | Host |
|---|---|---|
| cp1 | control plane | plex1 |
| cp2 | control plane | plex2 |
| worker1 | worker | plex1 |
| worker2 | worker | plex2 |
| worker3 | worker | plex2 |

The two Pis add a third control plane and a fourth worker, so the full cluster is
three control planes and four workers. On top of it runs my GitOps stack and the
local-AI experiments that kicked off the whole upgrade.

## What's next

Part 2 covers Proxmox: installing it on the two OptiPlex boxes and getting them
ready to run the cluster.

It's all learning, and the whole world's our stage.
