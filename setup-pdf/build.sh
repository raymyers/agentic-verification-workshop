#!/usr/bin/env bash
# Build setup.pdf from setup.typ. Uses typst if installed, else Nix.
set -euo pipefail
cd "$(dirname "$0")"
if command -v typst >/dev/null; then
  typst compile setup.typ setup.pdf
else
  nix run nixpkgs#typst -- compile setup.typ setup.pdf
fi
echo "Wrote $(pwd)/setup.pdf"
