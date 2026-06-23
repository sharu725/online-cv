---
layout: post
title: "Homelab, Part 3: A Talos Kubernetes Cluster on Proxmox and Raspberry Pis"
date: 2026-06-22 10:00:00
tags: [homelab, kubernetes, talos, cilium, gitops]
---

[Part 1]({{ '/2026/06/21/homelab-part-1-hardware.html' | relative_url }}) covered
the hardware; [Part 2]({{ '/2026/06/22/homelab-part-2-proxmox.html' | relative_url }})
got Proxmox running on the two OptiPlex Micros. This post is the payoff: a real
**Kubernetes cluster** stretched across those Proxmox VMs *and* the Raspberry
Pis from Part 1 — running **Talos Linux v1.13.4** and **Kubernetes v1.32.0**.

## Why Talos instead of "just install Kubernetes"

I didn't want to `apt install` a control plane and hand-maintain it. Talos Linux
is a purpose-built Kubernetes OS: **immutable, API-driven, and with no SSH and no
shell**. You don't log into a Talos node — you declare its config and apply it
over an API. That's a mindset shift, but it's exactly the production-style,
reproducible setup I wanted to practice: the whole cluster is described in
files, generated with **talhelper**, and the VMs themselves are created on
Proxmox with **OpenTofu**. Rebuilding a node is boring and repeatable instead of
a snowflake.

## The shape of the cluster

Seven nodes, deliberately mixed:

| Role | Nodes | Where |
|------|-------|-------|
| control plane | `cp1`, `cp2` | Proxmox VMs (amd64) |
| control plane | `cp3` | Raspberry Pi 5 (arm64) |
| worker | `worker1`, `worker2`, `worker3` | Proxmox VMs (amd64) |
| worker | `worker4` | Raspberry Pi 5 (arm64) |

A few deliberate choices in there:

- **Three control planes, not two.** Part 2 ended on the two-node quorum
  problem; the cluster answers it here. etcd wants an odd number for quorum, so
  the third control plane — a Raspberry Pi 5 — means the cluster survives losing
  any one control-plane node. A Pi makes a perfect tie-breaker: low power, and
  unlike a laptop it powers itself back on after an outage.
- **The control plane is spread across physical hosts**, so a single Proxmox box
  rebooting never takes the API down.
- **A floating virtual IP** (managed by Talos) is the cluster's API endpoint, so
  `kubectl` talks to "the cluster," not to one specific node.
- **Mixed architecture.** The amd64 VMs and arm64 Pis run side by side in one
  cluster — which keeps you honest about multi-arch container images.

## The troubles (this is a homelab, after all)

**Cilium + VXLAN silently ate cross-host traffic.** The cluster uses
[Cilium](https://cilium.io) as the CNI (with Hubble for flow visibility). With
the default VXLAN overlay, pods on the *same* node could talk, but pod-to-pod
traffic *across* nodes just… vanished — no error, just dropped packets. On
Proxmox the fix was switching Cilium to **native routing** instead of VXLAN.
Easily a lost evening if you don't suspect the overlay.

**The network interface name matters.** Talos pins addresses to a named NIC, and
the name isn't the same everywhere: Proxmox virtio NICs come up as `ens18`, while
the Raspberry Pi's onboard NIC is `end0`. Point the config at the wrong one and
the static IP (and the control-plane VIP) simply never come up.

**A bootstrap chicken-and-egg.** Cilium needs to reach the Kubernetes API to
start — but if you point it at the floating VIP, the VIP doesn't exist yet
because the control plane isn't up. The trick is to point Cilium at a *real*
control-plane node IP to bootstrap, then switch it to the VIP once the cluster is
healthy.

**Getting Talos onto a Raspberry Pi is its own little dance.** The Pis don't run
the stock Talos image — you build one with the `rpi_5` overlay (an Image Factory
schematic), flash it to the boot media, and the Pi comes up in Talos
**maintenance mode**, grabs a DHCP lease, and waits. From there you apply the
generated machine config and it joins. Worth knowing the Pi's onboard NIC is
`end0`, not `ens18` — same interface-name trap as above.

**You can't taint a Talos worker from its own config.** I wanted the Pi worker
(`worker4`) carrying a `NoSchedule` taint so heavy workloads stay on the beefier
amd64 nodes. Setting that via Talos `machine.nodeTaints` *fails* on workers —
kubelet's NodeRestriction admission won't let a node set its own taints, and the
failure also blocks the node labels declared alongside it. The fix is to apply
the taint out-of-band with `kubectl taint` after the node joins.

## Storage

Two storage classes, matching the hardware from Part 1:

- **`nfs`** (the default) — backed by the Buffalo NAS over NFS, for bulk and
  shared data.
- **`local-path`** — fast, node-local storage on the 2 TB SSDs in the Proxmox
  workers, for anything latency-sensitive.

## What runs on top

Everything is **GitOps**, managed by **ArgoCD** from a Git repo — Cilium,
cert-manager, the storage drivers, and ArgoCD itself all reconcile from version
control, so the cluster's desired state is the repo. On the workload side this is
where the original goal from Part 1 finally lands: **Ollama** for local LLMs, and
Plex with iGPU passthrough to one of the Proxmox workers.

## What's next

The cluster is up and self-managing. **Part 4** will go into the GitOps setup
proper — how ArgoCD bootstraps everything, secrets handling, and exposing
services with single sign-on.

Seven nodes, two architectures, one `kubectl` away — and finally a place to run
local AI that isn't someone else's cloud. It's all learning, and the stage just
got bigger.
