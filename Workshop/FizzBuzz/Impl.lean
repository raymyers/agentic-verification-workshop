/-!
# FizzBuzz: implementation

For each number: print "Fizz" if it is divisible by 3, "Buzz" if it is
divisible by 5, "FizzBuzz" if it is divisible by both, and the number itself
otherwise.
-/

namespace FizzBuzz

def fizzbuzz (n : Nat) : String :=
  if n % 15 = 0 then "FizzBuzz"
  else if n % 3 = 0 then "Fizz"
  else if n % 5 = 0 then "Buzz"
  else toString n

/-- FizzBuzz for `1, 2, ..., n`. -/
def fizzbuzzUpTo (n : Nat) : List String :=
  (List.range' 1 n).map fizzbuzz

#eval fizzbuzzUpTo 15

end FizzBuzz
