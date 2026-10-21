# Agentic Verification Workshop
> Materials for the workshop, "Agentic Formal Verification with Lean"

This session will provide an intro to Formal Verification and show the basics of using [Lean prover](https://lean-lang.org/) with and without coding agents.

## More to come

In the meantime, see resources in [How to Learn Theorem Provers](https://raymyers.org/post/how-to-learn-provers/) and [awesome-verified-coding-agents](https://github.com/raymyers/awesome-verified-coding-agents/tree/main) repo.


## Setup

### Lean prover (Required)

Lean has a [recommended installation](https://lean-lang.org/install/) as a VS Code extension and alternate [manual options](https://lean-lang.org/install/manual/).

### Your favorite coding agent (Required)

You can choose what agent to use. Here are some popular ones:

* [Claude Code](https://claude.com/product/claude-code)
* [Codex](https://learn.chatgpt.com/docs/codex/cli)
* [OpenCode](https://opencode.ai)
* [Pi](https://pi.dev/)

**Model choice**: Using Lean doesn't require the top frontier models but it is more advanced than normal coding. Here are the [OpenRouter](https://openrouter.ai/) names for some models that should work fine.

* deepseek-ai/DeepSeek-V4.1-Flash-1017
* anthropic/claude-sonnet-5.5

### Fallback

If you cannot install Lean you can use the [Lean web editor](https://live.lean-lang.org/) and code manually or copy-paste back and forth with a chatbot. This won't provide the full power of an agent feedback loop but it works for getting started.

### Install prompts (Optional)

A prompt pack called [lean4-skills](https://github.com/cameronfreer/lean4-skills/tree/main) helps agents navigate Lean proofs. We will cover some common setups here, see their [install guide](https://github.com/cameronfreer/lean4-skills/blob/main/INSTALLATION.md) for more.

**Claude Code** (run in chat):

```
/plugin marketplace add cameronfreer/lean4-skills
/plugin install lean4
```

**Codex** (in your shell)
```sh
codex plugin marketplace add cameronfreer/lean4-skills --ref main
codex plugin add lean4@lean4-skills
```

### Install MCP tools (Optional)

**Claude Code** (run in shell from repo root):

```sh
claude mcp add --transport stdio --scope user lean-lsp -- uvx lean-lsp-mcp
```

**Codex** (run in shell from repo root):

```sh
codex mcp add lean-lsp -- uvx lean-lsp-mcp
```

See [Codex MCP docs](https://learn.chatgpt.com/docs/extend/mcp)

## License

This repository is licensed under the [MIT License](LICENSE), with one exception:

* [`Workshop/GnuCash/`](Workshop/GnuCash/) contains material copied from or derived from [GnuCash](https://github.com/Gnucash/gnucash) and is licensed under the GNU GPL, version 2 or (at your option) any later version. See [`Workshop/GnuCash/LICENSE`](Workshop/GnuCash/LICENSE).
