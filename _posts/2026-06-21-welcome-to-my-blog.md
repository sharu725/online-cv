---
layout: post
title: "Welcome to my blog"
date: 2026-06-21
tags: [meta, learning]
---

This is the first post on my blog, where I'll write up things I learn while
building and running platform infrastructure — Kubernetes, Terraform, GitOps,
observability, and the occasional rabbit hole.

## Why a blog?

Writing things down forces me to actually understand them. The goal is short,
practical notes I'd want to find again later.

## How posts work

Each post is a Markdown file in `_posts/` named `YYYY-MM-DD-title.md` with a bit
of front matter at the top:

```yaml
---
layout: post
title: "Your title"
date: 2026-06-21
tags: [kubernetes, terraform]
---
```

Then just write Markdown. Code blocks, lists, and links all work:

- Fenced code blocks get syntax highlighting
- `inline code` is supported
- [Links](https://lalet.me) work as expected

That's it — commit, push, and it goes live.
