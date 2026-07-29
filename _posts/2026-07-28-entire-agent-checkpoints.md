---
layout: post
title: "Session Amnesia: Giving My Coding Agent a Memory"
date: 2026-07-28
tags: [ai, agentic-engineering, git, tooling]
---

I've been leaning on AI coding agents for a lot of my day to day work lately, and the thing nobody warns you about is how much good thinking just evaporates. The agent spends twenty minutes working through why one approach beats another, makes the change, and then the session ends. All that's left in the repo is a diff. The reasoning is gone the second the window closes.

<figure>
  <img src="https://media.giphy.com/media/VJqiFbOR5xwB8kf7HV/giphy.gif" alt="David Rose from Schitt's Creek saying 'I don't know what you're talking about'" loading="lazy">
  <figcaption>Me, opening a fresh agent session and asking it why the code looks the way it looks.</figcaption>
</figure>

## The part git was never built for

Git is great at recording what changed. It has never had an opinion about why, beyond whatever you bothered to type into a commit message. That gap barely mattered when a human wrote the code, since you could always walk over and ask them. It matters a lot more when the author is an agent, because there's no hallway conversation to fall back on. Ask an agent next week why it picked a particular tradeoff last week, and it has no idea. It's meeting the code for the first time all over again.

<figure>
  <img src="https://media.giphy.com/media/hML4qZmcTxLLrnkn2B/giphy.gif" alt="A man at a podium saying 'It is Groundhog Day again.'" loading="lazy">
  <figcaption>Every new agent session on a project that's been going for months.</figcaption>
</figure>

Multiply that across a real project. Every fresh session starts from zero context, so the agent either rediscovers the same constraints it already worked out weeks ago, or it never finds them at all and quietly does something a past version of itself already ruled out. Switch tools mid-project (a different agent, a different assistant) and you lose even more, because now there isn't even a shared history to rediscover from.

## What Entire actually does

[Entire](https://entire.io/) is a small, git native layer that closes that gap. The idea is simple: every time an agent makes a commit, Entire captures the session around it, the prompts, the back and forth, the tool calls, and links that capture to the commit itself. It doesn't touch your real branch or your commit history. All of that session data rides along on its own dedicated branch, so your actual git log stays exactly as clean as it's always been.

Once it's turned on for a project, it just works in the background. A normal `git push` carries the session data along with it automatically, so there's no separate habit to build or extra step to remember. The only visible sign it's there at all is one extra line of output when you push.

It's also not tied to a single agent. Since the session data lives at the git layer rather than inside any one tool, work can hand off between different coding agents on the same project without starting that history over from nothing.

## Setting it up

Turning it on for a project took about two minutes: install the CLI, point it at the coding agent I wanted it to track, and it was live. There was no config file to think through and no setting to second guess.

The one part that took a bit more patience was backfilling history for a project that already had months of agent sessions behind it before Entire existed. Importing that older history is an interactive step rather than a fire and forget command, since it walks through what it found and asks before committing to anything. I left that running in the background as a nice to have rather than something blocking the rest of the setup, since going forward matters more than backfilling the past.

## Why I think this actually matters

The simplest way I can put it: imagine hiring a brilliant intern who wakes up with total amnesia every morning. The work they finished yesterday is still sitting there, but why they built it that way is gone, so today's version has to stare at yesterday's code and guess. Entire is a notebook for that intern that survives the amnesia, glued to the actual commits instead of a chat window that gets closed and forgotten.

I don't think the pitch here is nostalgia for old chat logs. As more of a codebase gets written by agents instead of typed by hand, "why was this done this way" stops being something you can answer just by reading the diff. That reasoning needs somewhere durable to live, not a chat window that closes the second you're done with it. Code review already asks what changed. For AI authored changes, the more interesting question is what the agent was actually thinking, and right now that context has nowhere to persist unless something is deliberately keeping it.

It's a small thing to turn on. But six months into a project that's mostly agent authored, having an actual trail of the reasoning behind every commit feels like the difference between reviewing code and reviewing a stranger's homework.
