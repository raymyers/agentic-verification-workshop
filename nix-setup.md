### Using Nix

No flake is needed. If you don't have `uv` installed, let Nix provide it when the MCP server starts. Adding `elan` as well means you don't need Lean installed either: elan fetches the version pinned in `lean-toolchain`. Drop `nixpkgs#elan` if you already have elan.

**Claude Code**:

```sh
claude mcp add --transport stdio --scope user lean-lsp -- \
  nix shell nixpkgs#uv nixpkgs#elan --command uvx lean-lsp-mcp
```

**Codex**:

```sh
codex mcp add lean-lsp -- nix shell nixpkgs#uv nixpkgs#elan --command uvx lean-lsp-mcp
```

Use `nixpkgs#elan` rather than `nixpkgs#lean4`, because the nixpkgs Lean version may not match `lean-toolchain`. The first start is slow while Nix and elan download. After that it's cached. These commands need the `nix-command` and `flakes` features, which Determinate Nix turns on by default.
