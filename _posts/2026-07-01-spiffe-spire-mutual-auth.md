---
layout: post
title: "Workload Identity for Pods: A SPIFFE/SPIRE Primer"
date: 2026-07-01
tags: [cilium, spiffe, spire, kubernetes, security]
---

Most Kubernetes network policy answers one question: can this IP reach that IP, on this port. It never asks who's actually on the other end. [SPIFFE](https://spiffe.io/) and [SPIRE](https://spiffe.io/docs/latest/spire-about/spire-concepts/) exist to answer that second question, and I ended up wiring them into my own cluster to gate a specific pod-to-pod link. Here's what they are, and how the build went.

<figure>
  <img src="https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExZ3lpdGhleHp0dzNncmYzYWhkZzgxZXZ6cnd1YW9wcWMzN2F5czNpeiZlcD12MV9naWZzX3NlYXJjaCZjdD1n/l4dLyz1rYq1eK2AIsD/giphy.gif" alt="A bouncer standing with arms crossed, guarding a door" loading="lazy">
  <figcaption>Basically what mutual authentication does at every hop, minus the beret.</figcaption>
</figure>

## The problem with IP-based trust

A Kubernetes `NetworkPolicy` (or its Cilium equivalent) typically allows traffic based on labels and namespaces, which the control plane resolves down to IP addresses under the hood. That works, but it's trusting the network, not the workload. If something compromises a node or spoofs a source IP, a policy built purely on "traffic from this subnet is fine" has nothing left to check.

SPIFFE flips that around. Every workload gets a cryptographic identity, independent of where it happens to be running, and services can require proof of that identity before talking to each other. It's the same idea behind mutual TLS, standardized so any workload orchestrator can plug into it.

<figure>
  <img src="https://media.giphy.com/media/v1.Y2lkPWVjZjA1ZTQ3bGxucW0wdWNxcTMycWEyNDVpOWRmNTR4N2J0djQ4dWxsanN6Y3pkeCZlcD12MV9naWZzX3NlYXJjaCZjdD1n/lL7kQLUCBD7a4LGwZS/giphy.gif" alt="Line drawing of a dog with the caption 'IAM is hard.' and hashtag HeckinIAM" loading="lazy">
  <figcaption>Identity and access management in one honest sentence.</figcaption>
</figure>

## What SPIFFE and SPIRE actually are

[SPIFFE](https://spiffe.io/docs/latest/spiffe-about/spiffe-concepts/) is a specification: it defines a URI format for workload identity (a **SPIFFE ID**, like `spiffe://example.org/my-service`) and a document format for proving it (an **SVID**, a short-lived X.509 certificate or JWT that attests "I am this identity, signed by an authority you trust"). It doesn't run anything by itself.

[SPIRE](https://spiffe.io/docs/latest/spire-about/spire-concepts/) is the reference implementation. It has a server that acts as the certificate authority for a **trust domain**, and an agent on each node that figures out what's actually running there (which pod, which service account, which container image) and matches it against registered rules. If a workload's real, observed attributes match a rule, the agent hands it a short-lived SVID. No shared secret gets baked into an image or mounted as a static file. The certificate is minted just for that workload, at runtime, based on what it verifiably is.

## Where Cilium fits in

I run [Cilium](https://cilium.io/) for cluster networking already, and it has a built-in integration that uses SPIRE as its identity backend: [mutual authentication](https://docs.cilium.io/en/stable/network/servicemesh/mutual-authentication/mutual-authentication/). Enable it, and a `CiliumNetworkPolicy` rule can carry an `authentication.mode: required` flag. Traffic covered by that rule only passes once both ends have proven their SPIFFE identity to each other. Everything else in the cluster keeps working exactly as before, since the requirement is opt-in per rule, not global.

Enabling the feature deploys a SPIRE server and an agent on every node. The server issues identities; the agents are the local point of contact each node's workloads talk to when they need one.

## Building it for a real link

I used this to gate traffic between my self-hosted AI assistant and a local model backend it talked to. The assistant has broad capabilities (shell access, file access), so I wanted every hop it makes to be deliberate and provable, not just "same cluster, must be fine."

The rollout was mostly turning the feature on and writing one policy rule with `authentication.mode: required` on it. The two gotchas that actually cost time were both about visibility and staleness, not the core mechanism:

- The identity registrar's logs were, by default, invisible at the normal log level. I had to bump verbosity temporarily to actually see registration events happening, confirm it, then turn it back down.
- One identity got stuck unregistered, and a plain restart of the component responsible didn't fix it. It needed a forced leadership handoff to trigger a genuinely fresh resync, not just a restart of the same instance.

Neither is a flaw in the design so much as normal early-days friction with a feature that's still marked beta upstream. Once past that, the behavior was exactly as advertised: kill the identity provider mid-flight, and covered traffic fails closed rather than falling back to trusting the network.

<figure>
  <img src="https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExaGMwYnA3d3didG9xa3FvM3lqM3k5ajB2cjVxYWgzbWxseGNzZGhkaiZlcD12MV9naWZzX3NlYXJjaCZjdD1n/pgcz9Arntj2Zq/giphy.gif" alt="A black cat filing its claws with a nail file" loading="lazy">
  <figcaption>Me, sharpening my policy rules after the second gotcha.</figcaption>
</figure>

## Why bother

The honest case for this is defense in depth, not paranoia. Namespace isolation and network policy already cover most of what a homelab needs. SPIFFE/SPIRE is for the specific case where you have one link you want to be genuinely sure about, cryptographically, not just topologically, and you're willing to run the extra control plane to get it. For everything else, a solid default-deny policy and a service account with no permissions does most of the actual work.

<figure>
  <img src="https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExaGMwYnA3d3didG9xa3FvM3lqM3k5ajB2cjVxYWgzbWxseGNzZGhkaiZlcD12MV9naWZzX3NlYXJjaCZjdD1n/WSrPRXyADD2SUpb5in/giphy.gif" alt="A finger poking a black paw, claws extending in response" loading="lazy">
  <figcaption>The claws only need to come out for the link that actually matters.</figcaption>
</figure>

## References

- [SPIFFE overview](https://spiffe.io/)
- [SPIFFE concepts](https://spiffe.io/docs/latest/spiffe-about/spiffe-concepts/)
- [SPIRE concepts](https://spiffe.io/docs/latest/spire-about/spire-concepts/)
- [Cilium mutual authentication](https://docs.cilium.io/en/stable/network/servicemesh/mutual-authentication/mutual-authentication/)
