Use when porting code to Lean 4, writing specs as theorems, or proving them, in a project WITHOUT Mathlib and WITHOUT a Lean LSP/MCP. Covers the compile loop, core-library facts, and the verification gate.

# Lean 4 (core only) — port, specify, prove

## Loop
- Toolchain: read `lean-toolchain`. No Mathlib. Use only core `Init`/`Std`. Do not add deps.
- Check one file: `lake env lean path/File.lean 2>&1 | grep -v 'ld64\|warning: /'`
  (the error text includes unsolved goals). Build all: `lake build 2>&1 | grep -E 'error|✖|Build'`.
- Scratch probes (`#check @Name`, `#eval`, `example ... := by exact?`): write to a scratch
  `.lean` file and run `lake env lean` on it. Import project modules as needed.
- Find lemmas: `#check` the guessed name first. Then grep the toolchain source:
  `grep -rn "theorem .*NAME" ~/.elan/toolchains/*$(cut -d: -f2 lean-toolchain)*/src/lean/Init`.
  Probe with `exact?` / `apply?` / `simp?`, and copy what they print.
- Edit `.lean` files with the editor tool, not sed/perl on proofs. Rebuild after every change.
  Read warnings too: deprecations name their replacement.

## Core-Lean facts (no Mathlib)
- `Rat` is exact. `decide` does NOT evaluate `Rat`. Use `#guard expr == expected` for executable
  tests, and `grind` / rewriting for proofs.
- `grind` handles linear arithmetic and ring/field normalisation on `Int`/`Rat`, and usually
  closes leftover `0 + x` goals after `simp only [...]`. It is weak at nonlinear inequalities, so
  use `Rat.mul_nonneg`, `Rat.inv_pos`, `Rat.div_def` and similar explicitly. Many Mathlib names
  (e.g. `div_nonneg`) don't exist, so `#check` first.
- `omega` for `Nat`/`Int` linear goals. `simp_all`, `fun_induction f x <;> simp_all [...]` for
  recursive defs. `termination_by xs.length` for non-structural recursion.
- `Except` has no `BEq`, so compare `.toOption`. A doc comment cannot precede `#guard`.
- When a `let` blocks `split at h`, run `dsimp only at h` first. Prefer `cases l` over `split` on
  a `match` to keep names. If `cases h : e` hits "dependent elimination", use `by_cases`.

## Workflow
1. Port function-by-function, citing source line numbers in comments. Keep the port close to
   the source, quirks included.
2. Encode the upstream tests/fixtures as `#guard`s. They must pass BEFORE you prove theorems.
3. State specs as theorems about the port. Build with `sorry` first to check the statements
   typecheck, then prove them one at a time.
4. If a planned statement is false, find a concrete counterexample, add the weakest
   hypothesis that fixes it, and LOG it (statement, counterexample, hypothesis) in the
   trouble log. Never silently weaken, delete or `sorry` a stated theorem.
5. Keep the plan file current. Tick boxes only when the build is green.

## Done gate
- `lake build` is green, and `grep -rn "sorry\|native_decide\|admit" <module dir>` is empty
  (except designated exercise files).
- Axioms: generate `#print axioms` for every declaration and run it:
  ```bash
  { echo "import Workshop"; grep -hoE '^(private )?(theorem|lemma|def) [^ ]+' Path/*.lean \
      | awk '{print "#print axioms " $NF}'; } > /tmp/ax.lean   # names must be fully qualified
  lake env lean /tmp/ax.lean | grep -E 'sorryAx|ofReduceBool' && echo FAIL || echo OK
  ```
  Allowed: `propext`, `Classical.choice`, `Quot.sound`.
````
