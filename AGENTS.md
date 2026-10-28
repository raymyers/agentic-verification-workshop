# Lean 4 (core only): port, specify, prove

This repo uses core Lean only, with no Mathlib. Everything below works with plain shell access,
and doesn't need a Lean skill pack or LSP/MCP server (use them if you have them).

## Loop
- Toolchain: read `lean-toolchain`. Use only core `Init`/`Std`. Do not add deps.
- Run `lake build` once first, so that scratch files can import `Workshop.*`.
- Check one file: `lake env lean path/File.lean 2>&1 | grep -v 'ld64\|warning: /'`.
  Build all: `lake build 2>&1 | grep -E 'error|✖|Build'`. New modules must be imported in
  `Workshop.lean`, or `lake build` never checks them.
- See the goal: put `trace_state` in the proof, or stop the proof early. The error prints the
  hypotheses and the unsolved goal.
- Ask Lean for a proof: `try?` (tries many tactics), `exact?`, `apply?`, `simp?`, `grind?`.
  Paste the tactic they print. To try several tactics in one compile, use
  `first | omega | grind | simp_all`, or put several `example`s in one scratch file.
- Scratch probes (`#check @Name`, `#print Name`, `#eval`, `example`): write a scratch `.lean`
  file and run `lake env lean` on it.
- Find lemmas: `#check` the guessed name first. Then grep the toolchain source:
  `grep -rn "theorem .*NAME" ~/.elan/toolchains/*$(cut -d: -f2 lean-toolchain)*/src/lean/Init`.
- Edit `.lean` files with your file-editing tool, not sed/perl on proofs. Rebuild after every
  change. Read warnings too: deprecations name their replacement.

## Core-Lean facts (no Mathlib)
- These Mathlib habits don't exist here: `ring`, `linarith`, `nlinarith`, `norm_num`,
  `positivity`, `field_simp`, `lemma`. Use `grind`, `omega`, `simp`, `decide`, `theorem`.
  Many Mathlib lemma names (e.g. `div_nonneg`) don't exist either, so `#check` first.
- `omega` for `Nat`/`Int` linear goals. `simp_all`, `fun_induction f x <;> simp_all [...]` for
  recursive defs. `termination_by xs.length` for non-structural recursion.
- `grind` handles linear arithmetic and ring/field normalisation on `Int`/`Rat`, and usually
  closes leftover `0 + x` goals after `simp only [...]`. It is weak at nonlinear inequalities, so
  use `Rat.mul_nonneg`, `Rat.inv_pos`, `Rat.div_def` and similar explicitly.
- `Rat` is exact. `decide` does NOT evaluate `Rat`. Use `#guard expr == expected` for executable
  tests, and `grind` / rewriting for proofs.
- `Except` has no `BEq`, so compare `.toOption`. A doc comment cannot precede `#guard`.
- When a `let` blocks `split at h`, run `dsimp only at h` first. Prefer `cases l` over `split` on
  a `match` to keep names. If `cases h : e` hits "dependent elimination", use `by_cases`.

## Workflow
- Exercises with a given `Spec.lean`: replace each `sorry` with a proof. Do NOT change the
  theorem statements or `Impl.lean` to make a proof go through. If a statement looks false,
  stop and report a concrete counterexample.
- When porting code:
  1. Port function-by-function, citing source line numbers in comments. Keep the port close to
     the source, quirks included.
  2. Encode the upstream tests/fixtures as `#guard`s. They must pass BEFORE you prove theorems.
  3. State specs as theorems about the port. Build with `sorry` first to check the statements
     typecheck, then prove them one at a time.
  4. If a planned statement is false, find a concrete counterexample, add the weakest
     hypothesis that fixes it, and log it (statement, counterexample, hypothesis) in `NOTES.md`
     in the exercise folder. Never silently weaken, delete or `sorry` a stated theorem.
  5. Keep a plan checklist in that `NOTES.md`. Tick boxes only when the build is green.

## Done gate (for the folder you worked on)
- `lake build` is green, and `grep -rn "sorry\|native_decide\|admit" Workshop/<Dir>` only hits
  comments.
- Axioms: print them for every declaration. `NS` is the `namespace` the files use:
  ```bash
  D=Workshop/FizzBuzz NS=FizzBuzz
  { echo "import Workshop"; echo "open $NS"; grep -hoE '^(theorem|def|abbrev) [^ ]+' $D/*.lean \
      | awk '{print "#print axioms " $NF}'; } > /tmp/ax.lean
  lake env lean /tmp/ax.lean 2>&1 | grep -E 'error|sorryAx|ofReduceBool' && echo FAIL || echo OK
  ```
  Any `error` (e.g. an unknown name) also means FAIL. Allowed axioms: `propext`,
  `Classical.choice`, `Quot.sound`.
