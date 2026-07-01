---
layout: post
title: "Give Yourself a Chat Bot: OpenRouter + OpenClaw + Telegram"
date: 2026-07-01
tags: [openclaw, openrouter, telegram, selfhosted, ai]
---

I wanted an AI assistant I could just text like a friend. Not a browser tab, not an app, just Telegram. Turns out you can wire that up in about twenty minutes with two free accounts and one open-source project. Here's the whole thing, start to finish.

## What you're building

[OpenClaw](https://openclaw.ai/) is a self-hosted AI assistant that runs as its own service and connects to chat apps (Telegram, WhatsApp, Slack, and a bunch more). [OpenRouter](https://openrouter.ai/) sits in front of dozens of AI models and gives you one API key that works with all of them, including several that cost nothing at all. Point OpenClaw at OpenRouter, wire up a Telegram bot, and you've got a chat assistant with zero monthly bill.

<figure>
  <img src="{{ '/assets/images/openrouter-activity.png' | relative_url }}" alt="OpenRouter activity dashboard showing $0.00 total spend, 67 requests, and 2.53M tokens used" loading="lazy">
  <figcaption>My actual usage after a week of poking at this. $0.00 spent.</figcaption>
</figure>

## What you need

- Somewhere to run OpenClaw: a spare server, a VM, a container, anything that can run Node. I run mine in a Kubernetes pod, but none of the steps below care where it lives.
- A free [OpenRouter](https://openrouter.ai/) account.
- A Telegram account.

## Step 1: Get an OpenRouter key, and pick a free model on purpose

Sign up at OpenRouter, then grab an API key from your account settings. Free, no card needed.

Here's the part that bit me: OpenRouter has a model called `auto` that picks whichever model it thinks is best for your prompt. Sounds convenient. The problem is `auto` isn't guaranteed to stay inside the free tier, so on a zero-balance account it can quietly route you to a paid model and then fail with "insufficient balance" the moment it does.

Skip `auto`. Pick an explicit free model instead, something with a `:free` suffix. You can browse the current list at [openrouter.ai/models, filtered to zero cost](https://openrouter.ai/models?max_price=0). I'm running `nvidia/nemotron-3-ultra-550b-a55b:free`, a 1M-context model with tool-calling support, which matters if you want your assistant to actually do things and not just chat.

Free models are capped at 50 requests a day and 20 a minute on a zero-balance account. If that's tight, a one-time $10 top-up permanently raises the cap to 1000 a day, whether or not you ever spend the rest of that balance on anything else.

## Step 2: Install OpenClaw and point it at OpenRouter

Follow OpenClaw's own [install docs](https://docs.openclaw.ai/) for your platform. Once it's running, you need to tell it two things: which model to use, and where your OpenRouter key lives.

If you're running it somewhere without an interactive terminal (a container, a headless server), OpenClaw's normal setup wizard won't work, since it needs a TTY. Use its config command instead:

```bash
openclaw config set --replace --batch-json '[
  {"path":"gateway.mode","value":"local"},
  {"path":"agents.defaults.model.primary","value":"openrouter/nvidia/nemotron-3-ultra-550b-a55b:free"}
]'
```

And set your key as an environment variable wherever OpenClaw runs:

```bash
export OPENROUTER_API_KEY="your-key-here"
```

No extra provider config needed. OpenRouter is a built-in provider; the env var and the model name above are all it takes.

## Step 3: Make a Telegram bot

Open Telegram, search for [@BotFather](https://t.me/BotFather), and send it `/newbot`. Answer the two questions it asks (a display name, then a username ending in `bot`), and it'll hand you back a token that looks like `123456789:ABCdefGhIJKlmNoPQRsTUVwxyZ`. That's your bot's password. Don't post it anywhere public.

## Step 4: Wire the bot token in and turn the channel on

Same pattern as the model config:

```bash
export TELEGRAM_BOT_TOKEN="your-bot-token-here"

openclaw config set --replace --batch-json '[
  {"path":"channels.telegram.enabled","value":true},
  {"path":"channels.telegram.groupPolicy","value":"disabled"}
]'
```

`groupPolicy: disabled` just means this bot only talks to you in DMs, not in group chats. Leave that off if you want group support later.

Restart OpenClaw so the new config takes effect.

## Step 5: Say hello, then approve yourself

Open Telegram, find the bot you just created, and send it any message, `/start` works fine. It won't reply yet. Behind the scenes it just generated a pairing request, and approving that is a one-time command, not a button in the chat:

```bash
openclaw pairing list telegram
```

That prints a short code next to your Telegram user ID. Approve it:

```bash
openclaw pairing approve telegram YOUR_CODE_HERE
```

That's it. You're paired, and if this is the first person ever approved, OpenClaw also makes you the bot's owner.

## Step 6: Talk to it

Send the bot a real message. You should get a real reply, generated by the free model on OpenRouter, delivered straight to your phone.

<figure>
  <img src="{{ '/assets/images/telegram-chat.png' | relative_url }}" alt="A phone screenshot of a Telegram chat with a bot named Rocky, replying with real content" loading="lazy">
  <figcaption>Mine, replying from my phone. It'll only know what you tell it.</figcaption>
</figure>

## Snags I actually hit

If you get an "insufficient balance" error out of nowhere, you're probably still on `openrouter/auto` and it picked a paid model without asking. Pin an explicit `:free` model instead (Step 1).

Rate limit errors mean you've gone past the free tier's 50 requests a day or 20 a minute. Slow down, or do the $10 top-up.

If your config seems to reset itself after a restart, you're writing it somewhere that doesn't survive a container restart. Move it to persistent storage.

And if the bot stays silent after `/start`, that's normal. Pairing is a manual step, not automatic. Run `openclaw pairing list telegram` and approve your code.

That's the whole setup. No monthly bill, and a bot in my pocket that only knows what I told it.
