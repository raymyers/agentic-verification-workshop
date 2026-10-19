import Workshop.LeftPad.Impl

/-!
# Left-pad: specification

These are the three requirements from "Let's Prove Leftpad":
1. The output is `max n s.length` long.
2. The prefix is made of padding characters.
3. The suffix is the original input.

Replace each `sorry` with a proof.

Things to discuss once the proofs are done:
* Do these three properties pin down `leftPad` exactly?
* The proofs are about `List`. What would it take to state them for
  `leftPadString` instead?
-/

namespace LeftPad

theorem leftPad_length (c : α) (n : Nat) (s : List α) :
    (leftPad c n s).length = max n s.length := by
  sorry

theorem leftPad_prefix (c : α) (n : Nat) (s : List α) (i : Nat)
    (h : i < n - s.length) :
    (leftPad c n s)[i]? = some c := by
  sorry

theorem leftPad_suffix (c : α) (n : Nat) (s : List α) :
    (leftPad c n s).drop (n - s.length) = s := by
  sorry

end LeftPad
