# Tennis

A scoreboard that shows the score of a single tennis game. Sets and matches are out of scope.

## Requirements

1. **Winning:** a player wins the game once they have won at least four points *and* are at least two points ahead of their opponent.
2. **Running score:** zero, one, two and three points are called "Love", "Fifteen", "Thirty" and "Forty". The score is shown as player one's points, then player two's, for example "Thirty-Fifteen". A tie is shown with "-All", for example "Fifteen-All".
3. **Deuce:** if both players have at least three points and the score is tied, the score is "Deuce".
4. **Advantage:** if both players have at least three points and one player is one point ahead, the score is "Advantage" followed by that player's name.

A won game is shown as "Win for" followed by the winner's name.

## Files

- `Impl.lean`: the legacy code, ported from `tennis_game_3.gleam`, plus the kata's score table as `#guard` tests.
- `Spec.lean`: the requirements above as theorems to prove, followed by a refactoring exercise.

## Sources

- Code: [Tennis Refactoring Kata](https://github.com/emilybache/Tennis-Refactoring-Kata) by Emily Bache, `gleam/src/tennis_game_3.gleam`.
- Requirements: summarized from the [Tennis kata description](https://sammancoaching.org/kata_descriptions/tennis.html) at sammancoaching.org (CC-BY-SA-4.0).
