# GnuCash Advanced Portfolio

Source material for rebuilding a behavioral spec of GnuCash's **Advanced
Portfolio** report (`advanced-portfolio.scm`). The folder gathers the code, the
tests, a bug-report fixture, the user docs and the commit history. No spec has
been written yet.

Upstream snapshot: [Gnucash/gnucash](https://github.com/Gnucash/gnucash) branch
`stable` at `fec5643cd22cbafc7b16047f35cbe852395da947` (2026-10-19). The report
file last changed in `35ecad8d2` (2024-10-27).

## License

Unlike the rest of this repository (MIT), **everything in this folder is
licensed under the GNU GPL, version 2 or (at your option) any later version**,
because it is copied from or derived from GnuCash. See [LICENSE](LICENSE),
which is the upstream GnuCash license file and includes the GPL v2 text.

- `upstream/*.scm`: GnuCash source, GPL-2.0-or-later (see each file header).
- `fixtures/bug-710055-testcase.gnucash`: test book attached to GnuCash bug
  710055 by its reporter, Jason McCarty. It is redistributed here as part of
  the GnuCash project record.
- `Docs.md`: short quotes from the GnuCash Guide and Manual (gnucash-docs,
  GFDL), with links. Treat them as attributed quotes of the upstream docs.
- Notes and summaries written for this repo (`Bug-710055.md`, `History.md`, the
  tables below) are released under the same GPL-2.0-or-later terms.

## Contents

| Path | What it is |
|---|---|
| [Refs.md](Refs.md) | Original list of references |
| [upstream/advanced-portfolio.scm](upstream/advanced-portfolio.scm) | The report implementation (Guile Scheme, 1190 lines) |
| [upstream/test-portfolios.scm](upstream/test-portfolios.scm) | Current upstream regression tests for Portfolio and Advanced Portfolio |
| [upstream/test-engine-extras.scm](upstream/test-engine-extras.scm) | Test helpers, including `create-stock-test-data` (the fixture book the tests use) |
| [upstream/test-portfolios.2020-07-historical.scm](upstream/test-portfolios.2020-07-historical.scm) | The test file just before `6f1960313` (2020-08-01). It still has `advanced-helper-tests` with unit tests for the basis functions (see below) |
| [fixtures/bug-710055-testcase.gnucash](fixtures/bug-710055-testcase.gnucash) | Example book from bug 710055 (uncompressed GnuCash XML) |
| [Bug-710055.md](Bug-710055.md) | Bug 710055: expected vs actual results, the fix, a worked example |
| [Docs.md](Docs.md) | What the user docs say about columns, options and capital gains |
| [History.md](History.md) | Selected commit history of the report file |

## Reading the regression test

`test-portfolios.scm` runs the report on `create-stock-test-data` with default
options except for the basis method. It then checks the first data row. The
columns match the headers in `advanced-portfolio.scm` (lines 1026-1068), in
this order:

| Column | Average (default) | FIFO | LIFO (`filo-basis`) |
|---|---|---|---|
| Account | AAPL | AAPL | AAPL |
| Symbol | AAPL | AAPL | AAPL |
| Listing | NASDAQ | NASDAQ | NASDAQ |
| Shares | 42.00 | 42.00 | 42.00 |
| Price | $6.00 | $6.00 | $6.00 |
| Basis | $484.88 | $543.94 | $400.00 |
| Value | $252.00 | $252.00 | $252.00 |
| Money In | $800.00 | $800.00 | $800.00 |
| Money Out | $543.00 | $543.00 | $543.00 |
| Realized Gain | $227.88 | $286.94 | $143.00 |
| Unrealized Gain | -$232.88 | -$291.94 | -$148.00 |
| Total Gain | -$5.00 | -$5.00 | -$5.00 |
| Rate of Gain | -0.63% | -0.63% | -0.63% |
| Income | $4.00 | $4.00 | $4.00 |
| Brokerage Fees | $10.00 | $10.00 | $10.00 |
| Total Return | -$1.00 | -$1.00 | -$1.00 |
| Rate of Return | -0.13% | -0.13% | -0.13% |

The fixture (from `create-stock-test-data`): buy 1 AAPL @ $100, buy 1 @ $200,
sell 1 @ $400 with a $10 fee and a $300 capital-gain split, then three stock
splits (1→10, 10→100, and 100→33 with $4 cash-in-lieu), buy 10 @ $5, sell 1/2
@ $6 with a $2.50 capital-gain split, and a $150 spin-off. All dates fall in
1980-1981. Before `df6c77561` (2023-06) Money Out was $553.00 in all three
cases. That commit started adding sale brokerage fees to Money Out.

### Historical basis unit tests

From 2020-06-24 to 2020-08-01, upstream had refactored the basis helpers
(`sum-basis`, `units-basis`, `apply-basis-ratio`, `basis-builder`) into top-level
functions and unit-tested them. `6f1960313` reverted the report "to original
4.0 state", which made those helpers local to the renderer again, so the tests
were deleted. The tests targeted the refactored helpers (with exact Scheme
rationals rather than `gnc-numeric` rounding). They still document the intended
basis-list semantics: a list of `(units . per-unit-value)` lots, average vs
FIFO vs LIFO on buys and sells, splits/mergers (units with no value), and
spin-offs (value with no units).
