import Workshop.FizzBuzz.Impl

/-!
# FizzBuzz: specification

Replace each `sorry` with a proof.

Things to discuss once the proofs are done:
* Is this spec complete? Could a wrong `fizzbuzz` still satisfy all of it?
* The implementation checks `n % 15`, but the spec talks about 3 and 5.
  Which of these proofs needs that connection?
-/

namespace FizzBuzz

theorem fizzbuzz_of_dvd_both (n : Nat) (h3 : n % 3 = 0) (h5 : n % 5 = 0) :
    fizzbuzz n = "FizzBuzz" := by
  sorry

theorem fizz_of_dvd_three (n : Nat) (h3 : n % 3 = 0) (h5 : n % 5 ≠ 0) :
    fizzbuzz n = "Fizz" := by
  sorry

theorem buzz_of_dvd_five (n : Nat) (h3 : n % 3 ≠ 0) (h5 : n % 5 = 0) :
    fizzbuzz n = "Buzz" := by
  sorry

theorem number_otherwise (n : Nat) (h3 : n % 3 ≠ 0) (h5 : n % 5 ≠ 0) :
    fizzbuzz n = toString n := by
  sorry

/-- The list version produces one line per number. -/
theorem fizzbuzzUpTo_length (n : Nat) : (fizzbuzzUpTo n).length = n := by
  sorry

/-- Line `i` (counting from 0) is the answer for the number `i + 1`. -/
theorem fizzbuzzUpTo_get (n i : Nat) (h : i < n) :
    (fizzbuzzUpTo n)[i]? = some (fizzbuzz (i + 1)) := by
  sorry

end FizzBuzz
