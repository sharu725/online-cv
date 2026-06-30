---
layout: post
title: "Homelab, Part 8: The TLDR"
date: 2026-06-30
tags: [homelab, kubernetes, talos, gitops, overview]
---

Seven parts in, this thing is real and running, so here is the short version. One photo, one map, and a line on what each box actually does. The full story is linked at the bottom.

<figure>
  <img src="{{ '/assets/images/homelab-hardware.jpg' | relative_url }}" alt="Two Raspberry Pi 5s on PoE hats, two Dell OptiPlex 3070 Micro PCs, and a Buffalo NAS on a shelf" loading="lazy">
  <figcaption>The entire "datacenter". Two Raspberry Pi 5s on PoE hats, two Dell OptiPlex 3070 Micros, and a Buffalo NAS on the shelf below. The whole shelf pulls less power than a desktop at idle.</figcaption>
</figure>

## What it actually is

Seven [Talos Linux](https://www.talos.dev/) nodes make one Kubernetes cluster: three control plane, four workers, spread across [Proxmox](https://www.proxmox.com/) VMs on the two Dells and the bare Raspberry Pis. [Cilium](https://cilium.io/) does the networking. No SSH, no package manager, no pet servers. If a node dies I reflash it and it rejoins.

<figure>
  <img src="{{ '/assets/images/homelab-architecture.png' | relative_url }}" alt="Architecture diagram: clients to Cloudflare Zero Trust, into the Talos cluster grouped by GitOps, Platform and Identity, Observability, Applications and Storage, with the NAS and VPN outside" loading="lazy">
  <figcaption>Same stack, drawn out. Clients on the left, the cluster in the middle, the NAS and the VPN on the outside.</figcaption>
</figure>

## What runs on it

Everything below lives as YAML in one git repo. [ArgoCD](https://argo-cd.readthedocs.io/) watches that repo and makes the cluster match it, and [SOPS](https://github.com/getsops/sops) with an age key keeps the secrets encrypted right next to the code. I change the homelab by opening a pull request.

- **Login.** [Authentik](https://goauthentik.io/) is the single sign-on, sitting behind [Cloudflare Zero Trust](https://www.cloudflare.com/zero-trust/). One account gets me into Grafana, ArgoCD, and the dashboard, with a one-time PIN as backup.
- **Watching it.** [VictoriaMetrics](https://victoriametrics.com/) for metrics, [Loki](https://grafana.com/oss/loki/) plus Alloy for logs, [Hubble](https://github.com/cilium/hubble) for who-talks-to-who, all drawn in [Grafana](https://grafana.com/).
- **Media.** [Jellyfin](https://jellyfin.org/) transcodes on the Intel iGPU in one of the Dells. A download stack feeds it, and torrents only leave through a VPN that kills the connection if the tunnel drops.
- **Storage.** Three tiers. The Buffalo NAS serves bulk files over NFS, [Longhorn](https://longhorn.io/) does replicated block for databases, and node-local SSD handles anything that hates a network mount. [Garage](https://garagehq.deuxfleurs.fr/) covers S3 objects.

## The three rules I never broke

1. If it is not in git, it does not exist.
2. No secret in plaintext, anywhere, ever.
3. Nothing is reachable without a login in front of it. The one exception is the TV talking to Jellyfin over the LAN.

That is the homelab. Small shelf, boring rules, and I can rebuild the whole thing from a git clone.

## The long version

- [Part 1: Hardware]({{ '/2026/06/21/homelab-part-1-hardware.html' | relative_url }})
- [Part 2: Proxmox]({{ '/2026/06/22/homelab-part-2-proxmox.html' | relative_url }})
- [Part 3: Kubernetes]({{ '/2026/06/22/homelab-part-3-kubernetes.html' | relative_url }})
- [Part 4: ArgoCD]({{ '/2026/06/23/homelab-part-4-argocd.html' | relative_url }})
- [Part 5: Remote access]({{ '/2026/06/24/homelab-part-5-remote-access.html' | relative_url }})
- [Part 6: Observability]({{ '/2026/06/24/homelab-part-6-observability.html' | relative_url }})
- [Part 7: Single sign-on]({{ '/2026/06/25/homelab-part-7-single-sign-on.html' | relative_url }})
