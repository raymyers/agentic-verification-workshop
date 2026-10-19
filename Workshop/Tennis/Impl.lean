/-!
# Tennis: legacy implementation

A line-by-line port of `tennis_game_3.gleam` from the Tennis refactoring kata:
https://github.com/emilybache/Tennis-Refactoring-Kata/blob/main/gleam/src/tennis_game_3.gleam

The cryptic names, the `p1 + p2 == 6` check and the squared difference are
all from the original. Leave them alone until the spec is proved: they are
what the refactoring exercise cleans up. See `README.md` in this folder for
the requirements.
-/

namespace Tennis

structure TennisGame where
  p1 : Int
  p2 : Int
  p1N : String
  p2N : String
  deriving Repr, DecidableEq

def wonPoint (game : TennisGame) (playerName : String) : TennisGame :=
  match playerName with
  | "player1" => { game with p1 := game.p1 + 1 }
  | _ => { game with p2 := game.p2 + 1 }

def getScore (game : TennisGame) : String :=
  let { p1, p2, p1N, p2N } := game
  if p1 < 4 && p2 < 4 && !(p1 + p2 == 6) then
    let s := match p1 with
      | 0 => "Love"
      | 1 => "Fifteen"
      | 2 => "Thirty"
      | 3 => "Forty"
      | _ => panic! "panic expression evaluated"
    if p1 == p2 then
      s ++ "-All"
    else
      s ++ "-" ++
        match p2 with
        | 0 => "Love"
        | 1 => "Fifteen"
        | 2 => "Thirty"
        | 3 => "Forty"
        | _ => panic! "panic expression evaluated"
  else
    if p1 == p2 then
      "Deuce"
    else
      let s := if p1 > p2 then p1N else p2N
      match (p1 - p2) * (p1 - p2) with
      | 1 => "Advantage " ++ s
      | _ => "Win for " ++ s

/-! ## Characterization tests

These are the score table from the kata's test suites. Each game is built the
way the original tests build it: by calling `wonPoint` once per point. -/

def newGame : TennisGame := { p1 := 0, p2 := 0, p1N := "player1", p2N := "player2" }

def play (p1Points p2Points : Nat) : TennisGame := Id.run do
  let mut game := newGame
  for _ in [0:p1Points] do
    game := wonPoint game "player1"
  for _ in [0:p2Points] do
    game := wonPoint game "player2"
  return game

def scoreTable : List (Nat × Nat × String) := [
  (0, 0, "Love-All"), (1, 1, "Fifteen-All"), (2, 2, "Thirty-All"),
  (3, 3, "Deuce"), (4, 4, "Deuce"),
  (1, 0, "Fifteen-Love"), (0, 1, "Love-Fifteen"),
  (2, 0, "Thirty-Love"), (0, 2, "Love-Thirty"),
  (3, 0, "Forty-Love"), (0, 3, "Love-Forty"),
  (4, 0, "Win for player1"), (0, 4, "Win for player2"),
  (2, 1, "Thirty-Fifteen"), (1, 2, "Fifteen-Thirty"),
  (3, 1, "Forty-Fifteen"), (1, 3, "Fifteen-Forty"),
  (4, 1, "Win for player1"), (1, 4, "Win for player2"),
  (3, 2, "Forty-Thirty"), (2, 3, "Thirty-Forty"),
  (4, 2, "Win for player1"), (2, 4, "Win for player2"),
  (4, 3, "Advantage player1"), (3, 4, "Advantage player2"),
  (5, 4, "Advantage player1"), (4, 5, "Advantage player2"),
  (15, 14, "Advantage player1"), (14, 15, "Advantage player2"),
  (6, 4, "Win for player1"), (4, 6, "Win for player2"),
  (16, 14, "Win for player1"), (14, 16, "Win for player2")
]

#guard scoreTable.all fun (a, b, expected) => getScore (play a b) == expected

#eval getScore (play 3 2)

end Tennis
