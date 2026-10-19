/-!
# Left-pad: implementation

`leftPad c n s` pads `s` on the left with copies of `c` until it is at least
`n` long. Inputs that are already long enough come back unchanged.

The core function works on lists so the proofs can use the list library. The
`String` version is a thin wrapper around it.

See Hillel Wayne's "Let's Prove Leftpad" for the same exercise in many other
provers: https://github.com/hwayne/lets-prove-leftpad
-/

namespace LeftPad

def leftPad (c : α) (n : Nat) (s : List α) : List α :=
  List.replicate (n - s.length) c ++ s

def leftPadString (c : Char) (n : Nat) (s : String) : String :=
  String.ofList (leftPad c n s.toList)

#eval leftPadString '0' 5 "42"
#eval leftPadString '!' 2 "already long"

end LeftPad
