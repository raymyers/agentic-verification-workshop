import Workshop.Tennis.Impl

/-!
# Tennis: specification

## Part 1: pin down the legacy behavior

Replace each `sorry` with a proof. Together these theorems state the
requirements in `README.md` for every possible score, not just the rows in
`scoreTable`.

## Part 2: refactor

Write a cleaner `getScore'` and prove that it behaves exactly like the original:

    theorem getScore'_eq (game : TennisGame) : getScore' game = getScore game

Things to discuss:
* Scores are `Int` because Gleam's are. Which theorems need `0 ≤` hypotheses,
  and what would change if the fields were `Nat`?
* `wonPoint_other` holds for *any* name other than `"player1"`. Try to state
  "`wonPoint game game.p1N` gives player one a point." Can you prove it? What
  does that tell you about the original code?
-/

namespace Tennis

/-- The spec's own vocabulary for running scores. It is written separately
from the implementation so the theorems don't just restate the code. -/
def pointName (n : Int) : String :=
  if n = 0 then "Love"
  else if n = 1 then "Fifteen"
  else if n = 2 then "Thirty"
  else "Forty"

/-! ### Scoring points -/

theorem wonPoint_player1 (game : TennisGame) :
    wonPoint game "player1" = { game with p1 := game.p1 + 1 } := by
  sorry

theorem wonPoint_other (game : TennisGame) (name : String) (h : name ≠ "player1") :
    wonPoint game name = { game with p2 := game.p2 + 1 } := by
  sorry

/-! ### Reporting the score -/

/-- Rule 2: below three points each, a tied score is "<points>-All". -/
theorem score_all (game : TennisGame) (h0 : 0 ≤ game.p1) (h3 : game.p1 < 3)
    (heq : game.p1 = game.p2) :
    getScore game = pointName game.p1 ++ "-All" := by
  sorry

/-- Rule 2: otherwise, before deuce, each player's points are called by name. -/
theorem score_running (game : TennisGame)
    (h1 : 0 ≤ game.p1 ∧ game.p1 ≤ 3) (h2 : 0 ≤ game.p2 ∧ game.p2 ≤ 3)
    (hne : game.p1 ≠ game.p2) :
    getScore game = pointName game.p1 ++ "-" ++ pointName game.p2 := by
  sorry

/-- Rule 3: at three points or more each, a tie is "Deuce". -/
theorem score_deuce (game : TennisGame) (h3 : 3 ≤ game.p1) (heq : game.p1 = game.p2) :
    getScore game = "Deuce" := by
  sorry

/-- Rule 4: at three points or more each, one point ahead is "Advantage". -/
theorem score_advantage_p1 (game : TennisGame) (h3 : 3 ≤ game.p2)
    (h : game.p1 = game.p2 + 1) :
    getScore game = "Advantage " ++ game.p1N := by
  sorry

theorem score_advantage_p2 (game : TennisGame) (h3 : 3 ≤ game.p1)
    (h : game.p2 = game.p1 + 1) :
    getScore game = "Advantage " ++ game.p2N := by
  sorry

/-- Rule 1: at least four points and at least two ahead wins the game. -/
theorem score_win_p1 (game : TennisGame) (h4 : 4 ≤ game.p1)
    (h : game.p2 + 2 ≤ game.p1) :
    getScore game = "Win for " ++ game.p1N := by
  sorry

theorem score_win_p2 (game : TennisGame) (h4 : 4 ≤ game.p2)
    (h : game.p1 + 2 ≤ game.p2) :
    getScore game = "Win for " ++ game.p2N := by
  sorry

end Tennis
