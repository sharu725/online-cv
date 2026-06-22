---
layout: post
title: "Homelab, Part 1: Setting Up the Hardware"
date: 2026-06-21
tags: [homelab, infrastructure, proxmox, kubernetes]
---

This is the first post in a series on building out my homelab — a place to run
the same platform infrastructure I work on professionally (Kubernetes, GitOps,
observability) without a cloud bill attached to every experiment. Part 1 is the
foundation: the physical hardware and how it's wired together.

## How it started — and why it grew

I'd been running a homelab on a couple of Raspberry Pis for a while. They were
the perfect place to poke at things — small, cheap, low-power, and forgiving
when I broke them.

Then AI agents took off, and I wanted to experiment with running models locally
with **Ollama**. That's where the Pis hit a wall: great for tinkering, not so
great for anything compute- or memory-hungry. I wanted a real, multi-node
environment I could run a proper Kubernetes cluster on — and host local LLMs
without paying per token.

So I went shopping. The whole rule was **cheap**: everything here came off the
secondhand marketplace, which is exactly why mini-PCs and a few small boxes beat
a loud, power-hungry rack server.

## The hardware

Four small machines, a switch, and a NAS — nothing rack-mounted.

### Compute: 2× Dell OptiPlex 3070 Micro

The two workhorses, which I named **`plex1`** and **`plex2`**. They're identical,
so here's the spec for one node (both are the same):

| Component | Spec (per node) |
|-----------|-----------------|
| CPU | Intel Core i5-8500T — 6 cores / 6 threads, 35 W |
| RAM | 24 GB DDR4 |
| Boot disk | ~256 GB NVMe |
| Data disk | 2 TB SATA SSD |
| Hypervisor | Proxmox VE 9.2.3 |

The 3070 Micro hits the homelab sweet spot: a 35 W "T" CPU sips power and runs
silent, but six cores and 24 GB of RAM are plenty to host a multi-node cluster —
and finally enough headroom to run Ollama. The 2 TB SSD in each node holds the
VM disks (`local-ssd`); the smaller NVMe handles boot and Proxmox itself.

Two nodes instead of one bigger box was deliberate: it lets me split the
Kubernetes control plane across physical hosts and actually learn multi-node
clustering — the whole point of the exercise.

### 2× Raspberry Pi 5 — where it all started

The Pis are still around. They were the original homelab and my first set of
experiments, and they've earned a permanent spot. These days they handle the
lighter, always-on bits while the OptiPlex nodes do the heavy lifting.

### Storage: Buffalo TeraStation 5200 NVR

Bulk storage and backups live on a secondhand **Buffalo TeraStation 5200 NVR** —
a 2-bay business NAS, loaded with **2× 4 TB** drives. It has dual Gigabit ports,
so the box itself isn't the bottleneck; in practice it runs well behind the
node-local SSDs, which is exactly why it stays in the "cold storage / backups"
tier and each compute node keeps its own local 2 TB SSD for anything live or
performance-sensitive.

### Networking: TP-Link switch

Everything sits on a single flat LAN:

```
                Internet
                   │
          ┌────────┴─────────┐
          │   home router     │  gateway, DHCP
          └────────┬─────────┘
                   │
          ┌────────┴─────────┐
          │  TP-Link switch   │  unmanaged, 5 V powered
          └────────┬─────────┘
         ┌─────┬────┴───┬──────┬───────┐
       plex1  plex2   Buffalo  rpi5    rpi5
                       NAS
```

The switch is a plain, unmanaged 5 V-powered TP-Link unit — the same low-power
class of gear as the Pis themselves. No VLANs, no management, nothing fancy: the
OptiPlex Micros each have a single onboard 1 GbE NIC, and the switch just ties
the nodes, NAS, and Pis together off the home router. (Segmenting this into
VLANs is on the list for a later post.)

### Power & physical setup

It's all low-power by design — those 35 W CPUs idle quietly. **No UPS yet**;
that's the next purchase, because the one thing this setup can't currently
survive gracefully is a power blip.

## What's actually running on it

To make the hardware concrete — here's the current Kubernetes cluster, running
as Proxmox VMs spread across the two nodes:

| VM | Role | Host | vCPU | RAM |
|----|------|------|------|-----|
| `cp1` | control plane | `plex1` | 4 | 4 GB |
| `cp2` | control plane | `plex2` | 4 | 4 GB |
| `worker1` | worker | `plex1` | 6 | 16 GB |
| `worker2` | worker | `plex2` | 6 | 12 GB |
| `worker3` | worker | `plex2` | 6 | 6 GB |

Two control-plane nodes and three workers, with the control plane split across
physical hosts so a single node reboot doesn't take the cluster down. On top of
this runs my GitOps/observability stack and the local-AI experiments that
started this whole upgrade — the subject of later parts.

## Decisions and trade-offs

- **Secondhand mini-PCs over a rack server** — quiet, low-power, fits anywhere,
  and *cheap*. The cost is no IPMI/iLO and limited expansion, which I can live with.
- **Two nodes over one** — redundancy and a real multi-node cluster to learn on,
  rather than one big single point of failure.
- **Node-local SSD + a NAS for cold storage** — fast, node-local storage for
  anything live; the Buffalo NAS strictly for backups and bulk.

## What's next

With the metal racked (well, *shelved*) and on the network, **Part 2** covers the
virtualization layer: installing Proxmox, the `plex1`/`plex2` setup, and how the
Kubernetes VMs are laid out across them.

It's all learning — and the whole world's our stage, folks.
