---
layout: post
title: "Homelab, Part 2: Installing Proxmox"
date: 2026-06-22
tags: [homelab, proxmox, infrastructure]
---

[Part 1]({{ '/2026/06/21/homelab-part-1-hardware.html' | relative_url }}) covered
the hardware. This one is about Proxmox VE, the thing that turns those two mini
PCs into boxes I can carve VMs out of. Both nodes run version 9.

## Installing it

Flash the Proxmox ISO to a USB stick, boot the OptiPlex from it, and click
through the installer. The only real stop is the BIOS, where you turn on hardware
virtualization (VT-x/VT-d) so VMs can actually run.

## The subscription repo

Proxmox ships with its enterprise package repo enabled, and that one needs a paid
subscription. So your first `apt update` fails with a 401, and the web UI nags
you about it on every login. The fix is to switch to the free
`pve-no-subscription` repo and update. For a homelab that is the right call: same
packages, no support contract.

## Storage

The stock 256 GB drive is fine for Proxmox itself but fills up fast once VMs pile
on, so each node got a 2 TB SSD for the VM disks.

| Storage | Backed by | Holds |
|---|---|---|
| local | 256 GB NVMe | ISOs, templates, backups |
| local-lvm | 256 GB NVMe | small system disks |
| local-ssd | 2 TB SSD | the actual VM disks |

I used LVM-thin rather than ZFS. These are single-disk nodes without much spare
RAM, and ZFS wants more of both than this setup has to give.

## Networking

Proxmox creates a bridge (`vmbr0`) for the VMs, and I put it on the wired NIC
with a static address. The OptiPlex has Wi-Fi too, but Wi-Fi and bridged VMs
don't get along, so everything stays on Ethernet.

## To cluster or not

Proxmox can pool nodes into a cluster, but mine run as two standalone installs.
Two-node clusters are the awkward case: the quorum vote wants an odd number, so
two nodes really need a third tie-breaker before one rebooting takes the whole
thing down. I didn't want that babysitting, and the Kubernetes layer (next post)
gives me high availability above Proxmox anyway.

## What bit me

- The enterprise-repo 401 on the first update. Obvious once you know, confusing
  the first time.
- Forgetting the BIOS virtualization toggle before VMs will start.
- The stock drive is too small on its own. Budget for the extra SSD from day one.

## What's next

Proxmox is installed and the network is bridged. Part 3 is the part I actually
wanted to build: a Kubernetes cluster spread across both nodes and the Pis.
