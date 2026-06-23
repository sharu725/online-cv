---
layout: post
title: "Homelab, Part 3: A Kubernetes Cluster on Talos"
date: 2026-06-22 10:00:00
tags: [homelab, kubernetes, talos, cilium, gitops]
---

[Part 1]({{ '/2026/06/21/homelab-part-1-hardware.html' | relative_url }}) covered
the hardware and [Part 2]({{ '/2026/06/22/homelab-part-2-proxmox.html' | relative_url }})
got Proxmox running. This is where it comes together: a
[Kubernetes](https://kubernetes.io/) cluster spread across the Proxmox VMs and
the Raspberry Pis, running [Talos Linux](https://www.talos.dev/).

## Why Talos

I didn't want to hand-maintain a control plane. Talos is a Linux built only for
Kubernetes, with no SSH and no shell to log into. You don't manage a node by
poking at it, you declare its config and apply it over an API. That sounds
restrictive, and that's the point: the whole cluster lives in config files, so
rebuilding a node is boring and repeatable instead of a one-off.

## The cluster

Seven nodes, mixed on purpose:

| Role | Nodes | Where |
|---|---|---|
| control plane | cp1, cp2 | Proxmox VMs (amd64) |
| control plane | cp3 | Raspberry Pi (arm64) |
| worker | worker1, worker2, worker3 | Proxmox VMs (amd64) |
| worker | worker4 | Raspberry Pi (arm64) |

Three control planes, not two. Part 2 ended on the two-node quorum problem, and
this is the fix: [etcd](https://etcd.io/) wants an odd number, so a third control plane (a Pi) lets
the cluster survive losing any one of them. The control planes sit on different
machines, and a floating virtual IP is the API endpoint, so kubectl talks to the
cluster rather than to one node. The amd64 VMs and the arm64 Pis run side by
side, which keeps me honest about multi-arch images.

## The troubles

A few things cost me real time.

[Cilium](https://cilium.io/) dropped traffic between nodes. With the default overlay, pods on the same
node could talk but pods on different nodes couldn't, and it failed silently. On
Proxmox the fix was switching Cilium to native routing.

The interface name matters. Talos pins an address to a named NIC, and the name
isn't the same on the VMs as it is on the Pi. Point the config at the wrong one
and the address just never comes up.

There's also a bootstrap catch-22: Cilium needs the API to start, but the API's
floating IP doesn't exist until the control plane is already up. You point Cilium
at a real node to bootstrap, then move it to the floating IP once things settle.

## Storage

Two storage classes. NFS to the Buffalo NAS for bulk and shared data, and
local-path on the SSDs for anything that needs to be quick.

## What runs on it

Everything is GitOps through [ArgoCD](https://argo-cd.readthedocs.io/en/stable/),
so the cluster's state is just a Git repo. On top of that sits the reason for the
whole upgrade: [Ollama](https://ollama.com/) for local LLMs, and
Plex with the iGPU passed through for transcoding.

## What's next

The cluster is up and mostly runs itself. Part 4 gets into the GitOps setup: how
ArgoCD bootstraps everything, how secrets are handled, and how I reach services
with single sign-on.

Seven nodes, two architectures, one kubectl away. It's all learning, and the
stage just got bigger.
