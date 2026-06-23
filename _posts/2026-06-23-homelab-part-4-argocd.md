---
layout: post
title: "Homelab, Part 4: GitOps with ArgoCD"
date: 2026-06-23
tags: [homelab, kubernetes, argocd, gitops]
---

[Part 3]({{ '/2026/06/22/homelab-part-3-kubernetes.html' | relative_url }}) got
the Talos cluster running. Part 4 is how I stop touching it by hand.
[ArgoCD](https://argo-cd.readthedocs.io/en/stable/) watches a Git repo and
reconciles the cluster to match it. I push, it deploys.

## One repo, App-of-Apps

The repo (`argo-home`) is the source of truth. Change something live and ArgoCD
drifts it back; lose a node and the repo rebuilds it. I point ArgoCD at one
[ApplicationSet](https://argo-cd.readthedocs.io/en/stable/operator-manual/applicationset/)
that turns each folder into a managed app, so adding a service is a pull request,
not a kubectl session.

ArgoCD even manages itself. The only manual step is the first install; after that
it adopts its own manifests and upgrades through Git. It needs
[server-side apply](https://kubernetes.io/docs/reference/using-api/server-side-apply/),
or the big CRD manifests blow past the annotation size limit.

Today it keeps a deliberately short list in sync: ArgoCD,
[Cilium](https://cilium.io/), [cert-manager](https://cert-manager.io/), and the
two storage drivers. A few solid apps beat a dashboard full of
half-broken ones.

## Secrets with SOPS

Secrets live in the repo too, encrypted with [SOPS](https://github.com/getsops/sops)
and an [age](https://github.com/FiloSottile/age) key, so what gets committed is
ciphertext. ArgoCD decrypts them at render time with
[KSOPS](https://github.com/viaduct-ai/kustomize-sops), a generator plugin in the
repo-server. The only thing not in Git is the age private
key itself, loaded into the cluster once by hand. Each encrypted secret carries
its own namespace, so one app fans them out to wherever they belong.

Two things ate an afternoon:

- The KSOPS image has no shell, so an init container running `/bin/sh -c` just
  crash-loops. Call the binary directly.
- ArgoCD's command-params config map doesn't restart its pod when it changes.
  Restart it yourself, or run [Stakater Reloader](https://github.com/stakater/Reloader).

One catch: ArgoCD caches rendered manifests, decrypted secrets included, in Redis
as plaintext. The project discourages it for exactly that reason. Fine for a
private one-person cluster, not for anywhere with real blast radius.

## What else bit me

I started with [MetalLB](https://metallb.universe.tf/) and pulled it out once Cilium handled load balancing. And
on a fresh cluster, ApplicationSet order matters: namespaces have to exist before
the apps that land in them.

## Next

The cluster runs itself, but I still reach it over the local network. Part 5 is
exposing things properly: single sign-on with
[Authentik](https://goauthentik.io/), and getting in from outside without opening
the router.
