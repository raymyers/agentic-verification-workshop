# advanced-portfolio.scm: selected commit history

These commits come from `git log --follow` in
[Gnucash/gnucash](https://github.com/Gnucash/gnucash) (`stable`, as of
`fec5643cd2`). The file has three paths across its history:

- `src/report/standard-reports/advanced-portfolio.scm` (2002-2017)
- `gnucash/report/standard-reports/advanced-portfolio.scm` (`83d14e1c1`, 2017)
- `gnucash/report/reports/standard/advanced-portfolio.scm` (`438cf3c2b`, 2019)

`--follow` lists 140 commits. Some of them (2001-2002) actually belong to
`portfolio.scm`, which git's copy detection picks up. The list below keeps the
commits that change **behavior or tests**: new features, calculation fixes,
and changes to options and columns. It leaves out mechanical churn such as
renames, module moves, i18n string wrappers, API migrations, whitespace and
debug-message tweaks.

Bug numbers below 800000 are GNOME Bugzilla / bugs.gnucash.org IDs.

## 2002-2004: origin

| Commit | Date | Author | Change |
|---|---|---|---|
| `0f5a6b518` | 2002-10-01 | Derek Atkins (Herbert Thoma's patch) | **New report.** "shows money-in, money-out and gain of stock and fund accounts (based on the work of Martijn van Oosterhout and portfolio.scm by Robert Merkel)" |
| `123d988ed` | 2002-10-07 | Derek Atkins | Applied Matt Martin's advanced-portfolio patch |
| `b8e3289ed` | 2002-12-16 | David Hampton | Option for decimal places in the Shares column (#87164) |
| `9e1c90901` | 2003-04-20 | Derek Atkins | Herbert Thoma's multi-currency patch |
| `d67a2e21d` | 2003-05-21 | Derek Atkins | Handle commodities with no prices |
| `bd038f52e` | 2003-11-14 | Derek Atkins | Frank Pavageau's patch: capital gains with split transactions |
| `3335a2a14` | 2004-08-21 | Derek Atkins | Option to include zero-amount splits in computations (#143772) |

## 2006: multi-currency, basis and gains columns

| Commit | Date | Author | Change |
|---|---|---|---|
| `77099e354` | 2006-02-12 | Derek Atkins (Boris Zbarsky) | Count dividends and brokerage in money in/out (#311549) |
| `f0f721009` | 2006-02-12 | Derek Atkins (Mike Alexander) | Report currency option, sorted accounts, better "nearest price" handling (#314554). Reverted next day by `effc0e7a9` because it broke the report. |
| `b9525a269` | 2006-02-14 | Derek Atkins (Andrew Sackville-West) | Display options; fixed multicurrency patch (#314554, #330577) |
| `2307a95bd` | 2006-03-12 | David Hampton (Andrew Sackville-West) | Tidied multi-currency handling. Added **basis, realized and unrealized gain** columns. Uses `gnc_pricedb_lookup_latest_before`. |
| `82f717074` | 2006-06-28 | David Hampton | Sort order: group by parent, then by account code, then by name (#345385) |

## 2007-2009: Sackville-West overhaul (shipped in 2.2.2)

| Commit | Date | Author | Change |
|---|---|---|---|
| `85a860f0e` | 2007-12-08 | Andrew Sackville-West | **Major overhaul.** Stock splits/mergers in basis calculations. Fixed directly "expensed" shares. Fixes #343245, #347739, #460232. |
| `884b96b19` | 2007-12-10 | Andrew Sackville-West | Rounding in basis calculations to prevent overflow on large accounts |
| `8a56c9b8d` | 2007-12-12 | Andrew Sackville-West | **Spin-offs** in basis calculations |
| `411abc0d7` | 2007-12-19 | Andrew Sackville-West | Money in/out handling (#355660, partly #346062) |
| `669a26cf7` | 2007-12-22 | Andrew Sackville-West (Richard Laager) | **Income column**. Option to ignore brokerage fees in return calcs. |
| `945975bc5` | 2007-12-29 | Andrew Sackville-West | More rounding/overflow fixes ("phantom gains/losses from rounding errors") |
| `d6bab0ae4` | 2007-12-31 | Andrew Sackville-West | Dividends and fees: shared proportionally in multi-stock transactions. Reinvested dividends taken from the buy split and tracked apart from dividend income. Non-reinvested dividends count as income when a zero value/amount split ties them to the stock account. |
| `692cb0a4d` | 2008-01-03 | Andrew Sackville-West | Prevent `#unspecified` results from some transactions |
| `dd798ffac` | 2008-01-05 | Andrew Sackville-West | Report GUID |
| `b578c56b2` | 2009-11-20 | Christian Stimming | Currency trading accounts support (#537476) |
| `003d7209a` | 2009-12-17 | Mike Alexander | Guard against a missing pricing transaction |

The GnuCash 2.2.2 announcement lists these fixes:
#336240 (basis wrong for funds), #343245 (basis wrong with stock split),
#344566 (wrong Realized Gain), #347739 (wrong values with a capital loss),
#460232 (report fails), #487572 (breaks on "Most Recent to Report").

## 2011-2013: return columns (Bug 632931) and Bug 710055

| Commit | Date | Author | Change |
|---|---|---|---|
| `025314797` | 2011-06-21 | Geert Janssens (Sebastien Alborini) | Bug 632931: Income column showed negative amounts (sign fix) |
| `93535c955` | 2012-02-13 | Geert Janssens (Sebastien Alborini) | Bug 632931: "Total return is now an amount (not a percentage), and includes income as well as capital gains. New column 'Rate of return' gives the percentage." The default of "Ignore brokerage fees when calculating returns" changed to **not** ignore. |
| `02970201a` | 2012-09-02 | Geert Janssens | Bug 632931: **Rate of Gain** column |
| `bcac23f96` | 2013-10-22 | Geert Janssens (Jason McCarty) | **Bug 710055**: capital-gains split counted as dividend. See [Bug-710055.md](Bug-710055.md). |
| `443ac692e` | 2013-12-26 | Geert Janssens | Prevent gnc-numeric overflow |

## 2014-2015: Mike Alexander rework (GnuCash 2.6.x)

GnuCash NEWS: "Mike Alexander has extensively reworked the Advanced Portfolio"
report.

| Commit | Date | Change |
|---|---|---|
| `be931f767` | 2014-01-19 | "Share and price calculations are done to 5 decimal places and currency calculations are done using the precision defined for the currency." |
| `c7c68508c` | 2014-01-19 | Spin-off detection used an unset variable that was always zero. Better search for a pricing transaction. |
| `916ad28fc` | 2014-01-19 | UI says "LIFO". Internal symbol stays `filo-basis` so saved reports still work. |
| `ae96f2bff` | 2014-01-19 | Fix the basis calculations |
| `9d2687645` | 2014-01-19 | Fix realized gain calculation and handling of brokerage fees |
| `e4a3232e3` | 2014-01-19 | "Sometimes it would display one price but use another one to compute the value." Try harder to find a price. |
| `dd1dde78a` | 2014-01-19 | Removed the never-implemented "latest before" price source |
| `1f5b959f3` | 2014-01-19 | Footnotes only when the account that needs them is included |
| `7c4a52da2` | 2014-01-20 | Rounding tweak for bug #553020 |
| `7a576912c` | 2014-01-25 | Handle stocks that become worthless |
| `e842f0e75` | 2014-02-13 | **Main loop rewritten.** Option to include broker fees in basis. (Short-lived) option to ignore transfers to/from parent or sibling accounts. |
| `bfc02b6c2` | 2014-02-15 | Better calculation of income and money in to the share account. Dropped the parent/sibling option from the UI. |
| `3aacd3a1f` | 2014-02-18 | Removed the parent/sibling option completely |
| `b2f2f2520` | 2014-02-19 | Income moved to an asset account and back again does not count as money in |
| `b032a33b0` | 2014-02-19 | Money used in a spin-off counts as **money out** of the stock account |
| `d0766a6bb` | 2014-02-22 | More overflow fixes |
| `b1eb45ef2` | 2014-03-24 | FIFO/LIFO basis when less than one lot is sold |
| `f8139efad` | 2014-05-25 | Always value the account with the price that is displayed |
| `13abe849e` | 2015-01-18 | Income/expense: also match transactions from the parent account to an income/expense account whose name matches the stock account's name |
| `67edea72c` | 2015-01-18 | Bug 739228: Value converted correctly into the report's currency |
| `383d16609` | 2015-01-20 | That parent-account income search respects the report date |
| `7adc5e445` | 2015-10-29 | John Ralls: handle reversed prices from `gnc_pricedb_lookup*`. Before this, an older forward price could be preferred over a reverse price. |

## 2018-2019: robustness

| Commit | Date | Author | Change |
|---|---|---|---|
| `e0300d3a6` | 2017-12-21 | John Ralls | gnc:numeric pairs replaced with Scheme rationals (affects arithmetic) |
| `82ad7aca5` | 2018-02-15 | John Ralls | Prevent divide-by-zero errors |
| `84ab44bfb` | 2018-03-26 | Christopher Lam | Bug 792800: divide by zero when the stock balance goes negative. Shows `OVERFLOW-ERROR` instead of aborting. |
| `d8d3c669a` | 2019-02-05 | Christopher Lam | Bug 795729: percentages now show leading zeros (format string fix) |
| `22cdd237f` | 2019-02-21 | Christopher Lam | **First regression test**, `test-portfolios.scm` |
| `b26276cba` | 2019-05-17 | Christopher Lam | Bug 797241: include transactions dated on the report date (query end is 23:59:59) |

NEWS also lists these for 3.x: Bug 797102 "Advanced Portfolio Ignores Capital
Gain Splits", Bug 797106 (too many decimals in unit prices from
Finance::Quote), Bug 797137 (Advanced portfolio for currency accounts).

## 2020: refactor and revert

| Commit | Date | Change |
|---|---|---|
| `64637f72c` | 2020-06-24 | Helpers moved to top level for testing |
| `c12c6af2f` | 2020-06-24 | Tests: 100% coverage of the helpers (`advanced-helper-tests`) |
| `c68f28286` | 2020-06-24 | basis-builder simplified to use exact Scheme division, which is more accurate than `gnc_numeric_div`. "tests need to change slightly." |
| `945c11e2b`, `8d47622ab`, `150bfc8d1` | 2020-06/07 | More top-level moves and a fix for them |
| `6f1960313` | 2020-08-01 | **"restore to original 4.0 state and remove tests which cannot be run anymore."** The refactor was reverted and `advanced-helper-tests` deleted. The deleted tests are kept in [upstream/test-portfolios.2020-07-historical.scm](upstream/test-portfolios.2020-07-historical.scm). |

## 2021-2024: recent behavior changes

| Commit | Date | Author | Change |
|---|---|---|---|
| `8ffede531` | 2021-06-28 | Simon Arlott | Share decimal places up to 9 |
| `40c55899b` | 2022-12-23 | John Ralls | Options moved to the C++ options API (same options) |
| `9c87585d4` | 2023-02-05 | Christopher Lam | Bug 798747: `pricedb-before` branch in the price lookup ([announcement](https://lists.gnucash.org/pipermail/gnucash-changes/2023-February/020246.html)) |
| `df6c77561` | 2023-06-04 | fabrica64 | **Brokerage fees on sales added to Money Out** unless fees are ignored. Fees are shared in proportion to shares sold / shares traded. Test expectation for Money Out changed from $553.00 to $543.00. |
| `aca602103` | 2023-05-26 | Simon Arlott | Bug 798796: stock accounts under Bank accounts can be selected |
| `35ecad8d2` | 2024-10-27 | Christopher Lam | `xaccAccountGetSplitList` → `xaccAccountGetSplits` (performance only) |

### `df6c77561` core hunk

```scheme
;; Add brokerage fees to trans-sold if not ignoring them and there are any
(if (and (not (eq? handle-brokerage-fees 'ignore-brokerage))
         (gnc-numeric-positive-p trans-brokerage)
         (gnc-numeric-positive-p trans-shares))
    (let* ((fee-frac (gnc-numeric-div shares-sold trans-shares GNC-DENOM-AUTO GNC-DENOM-REDUCE))
           (fees (gnc-numeric-mul trans-brokerage fee-frac commod-currency-frac GNC-RND-ROUND)))
          (set! trans-sold (gnc-numeric-add trans-sold fees commod-currency-frac GNC-RND-ROUND))))
```

## Test file history (`test-portfolios.scm`)

| Commit | Date | Change |
|---|---|---|
| `22cdd237f` | 2019-02-21 | Initial commit |
| `182d4d9de` / `7557c5b54` | 2020-05 | New price renderer (Bug 797743); price shown as `$6.0000` for a while |
| `c12c6af2f` → `6f1960313` | 2020-06 → 08 | Helper unit tests added, then removed |
| `cec27308d` | 2022-12-22 | Converted to the new options API |
| `df6c77561` | 2023-06-04 | Money Out $553.00 → $543.00 |
| `0e041af55` | 2025-09-02 | Bug 799652: price shown as `$6.00` again |
