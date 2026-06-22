---
layout: post
title: "Homelab, Part 2: Installing Proxmox (and the Troubles Along the Way)"
date: 2026-06-22
tags: [homelab, proxmox, infrastructure]
---

In [Part 1]({{ '/2026/06/21/homelab-part-1-hardware.html' | relative_url }}) I
laid out the hardware: two Dell OptiPlex 3070 Micros, a couple of Raspberry Pis,
a Buffalo NAS, and a cheap switch. This post is about turning those two mini-PCs
into a virtualization platform — installing **Proxmox VE**, the bits that didn't
go smoothly, and the decisions I made along the way.

Both nodes run **Proxmox VE 9.2.3** today. Here's how they got there.

## Getting the installer onto the boxes

The install itself is the easy part: flash the Proxmox VE ISO to a USB stick,
boot the OptiPlex from it, and follow the prompts. The only stop along the way is
a quick trip into the OptiPlex BIOS — make sure hardware virtualization
(**Intel VT-x / VT-d**) is enabled and the USB stick is ahead of the internal
disk in the boot order.

<!-- TODO (optional war story): anything that actually fought you here? e.g.
Secure Boot, a stubborn USB boot, BIOS version quirks. Add a sentence if so. -->

## First boot: the subscription repo dance

This is the first thing that trips up almost everyone, and I was no exception.
Proxmox ships with the **enterprise APT repository** enabled, which needs a paid
subscription — so the very first `apt update` throws `401 Unauthorized`, and the
web UI greets you with a "No valid subscription" popup on every login.

These nodes run the community setup (no subscription key), so the fix was to
disable the `pve-enterprise` (and Ceph enterprise) repos, enable the
**`pve-no-subscription`** repository, then `apt update && apt full-upgrade`. For
a homelab, no-subscription is exactly the right call — same packages, just
without the enterprise support contract.

<!-- TODO (optional): mention if you also removed the nag popup, and which method. -->

## Storage layout

The OptiPlex ships with a single **256 GB SK hynix BC511 NVMe**, which Proxmox
takes over for boot — the default install carves it into `local` (ISOs, backups,
templates) and `local-lvm` (a thin pool for VM disks).

256 GB fills up fast once you're running a handful of VMs, so each node also got
a **2 TB TeamGroup T-Force SATA SSD**, added as its own LVM-thin pool
(`local-ssd`) where the real VM disks live:

| Storage | Disk | Type | Used for |
|---------|------|------|----------|
| `local` | 256 GB NVMe | dir | ISOs, templates, backups |
| `local-lvm` | 256 GB NVMe | LVM-thin | small / system VM disks |
| `local-ssd` | 2 TB SATA SSD | LVM-thin | main VM disk storage |

I went with **LVM-thin** rather than ZFS here — these are single-disk nodes with
modest RAM, so ZFS's memory appetite and the lack of a second disk for
redundancy made plain LVM-thin the simpler, lighter choice.

<!-- TODO (optional): any storage trouble — e.g. having to wipe an old
partition table before Proxmox would adopt the SSD? -->

## Networking

Proxmox sets up a Linux bridge, **`vmbr0`**, that the VMs hang off. On these
nodes `vmbr0` is bridged to the wired NIC with a static address on the LAN.

Worth noting: the OptiPlex also has onboard **Wi-Fi**, but it's left
unconfigured — Wi-Fi and bridged VM networking don't play nicely together, so
the homelab stays firmly on wired Ethernet.

<!-- TODO (optional): static IP vs DHCP reservation, NIC naming, or any bridge
gotcha worth a line. -->

## To cluster, or not to cluster

Proxmox can join multiple nodes into a cluster for a single management UI, live
migration, and HA. Right now, though, **the two nodes run standalone** — two
independent Proxmox installs rather than one cluster.

That's deliberate. A two-node cluster is the awkward case for Proxmox: corosync
wants an odd number of votes for quorum, so two nodes need a third tie-breaker
(a QDevice) to avoid losing quorum the moment one reboots. For a lab that didn't
feel worth the babysitting — and the Kubernetes layer (next post) gives me HA
*above* Proxmox anyway, so I don't need cluster-level HA underneath.

<!-- TODO: confirm this is the real reason. If you actually tried clustering and
backed out — or plan to add a QDevice later — tell me and I'll adjust. -->

## Troubles, in summary

The honest list of what cost time, so future-me (and you) can skip it:

- The **enterprise-repo `401`** on the first `apt update` — expected, but
  confusing the first time. Switch to `pve-no-subscription`.
- Remembering the **BIOS virtualization** toggles before VMs will run.
- Sizing storage up front — the stock 256 GB NVMe is not enough on its own;
  budget for that extra SSD from day one.
- The **two-node quorum** question above, which is really a "don't cluster two
  nodes without thinking it through" lesson.

<!-- TODO: add any other real troubles you hit — this section is the heart of
the post, so your specifics make it far better than the generic list above. -->

## What's next

With Proxmox installed, storage carved up, and the network bridged, **Part 3**
is the fun part: standing up the Kubernetes cluster as VMs across both nodes —
the `cp1`/`cp2` control plane and the workers from Part 1.

<!-- TODO: one-line sign-off in your voice. -->
