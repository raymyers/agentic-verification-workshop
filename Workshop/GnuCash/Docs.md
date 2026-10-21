# What the GnuCash docs say

Quotes are from the GnuCash documentation (gnucash-docs, GFDL). The links go to
the full text.

- Guide, *Standard Reports Overview*:
  <https://www.gnucash.org/docs/v5/C/gnucash-guide/rpt_standardrpts.html>
- Manual, *Report classes*:
  <https://www.gnucash.org/docs/v5/C/gnucash-manual/report-classes.html>

## Overview (Guide §10.3.2.1)

> The Advanced Portfolio produces a report on commodity accounts (stock and
> mutual fund type accounts) using price information stored in the GnuCash price
> database and within the GnuCash transaction data. If you do not have stock
> price information in your file, the report will indicate an error.

> This report includes extended information about commodity holdings, including
> information about the basis, gain, and return of individual commodities.

## Capital gains (Guide §10.3.2.1.1) {#capital-gains}

> The Advanced Portfolio report doesn't use the capital gain splits to calculate
> capital gains. It calculates the gains from the various buy and sell
> transactions in the account without regard to whether the gains and losses are
> recorded or not. Any realized gain splits are ignored.

> Realized gain splits are recognized as two splits, one in the stock's account
> with a zero number of shares and a non-zero value, the other in an income or
> expense account with a value that is the negative of the split in the stock
> account.

> These two splits can be in a separate transaction (as created by scrubbing) or
> in the same transaction as the sale (this will cause incorrect future
> scrubbing).

> The income or expense split can be split into multiple splits, say for
> taxable/non-taxable or short/long term gains, without affecting this report.

## Columns (Manual §9.3.2)

| Column | Definition in the manual |
|---|---|
| Account | Stock account |
| Symbol | Ticker symbol/abbreviation from the Security Editor. An option can hide it. |
| Listing | Type from the Security Editor. An option can hide it. |
| Shares | Number of shares. An option sets the decimal places. An option can hide it. |
| Price | "Unit market price as at report date." An option can hide it. |
| Basis | "Cost of all shares acquired by any means, including brokerage fees if the option to include them is checked." Method: Average, LIFO or FIFO. |
| Value | "Number of shares * Unit market price as at report date" |
| Money In | "Sum of the cost of stock purchased, excluding stock acquired as part of a Dividend Reinvestment Plan. I.e. External money used to purchase shares." |
| Money Out | "Money from selling shares or a spin off transaction." |
| Realized Gain | "Money received for selling shares minus basis for shares sold, minus brokerage fees for the sale if the option to include them in basis is checked." |
| Unrealized Gain | "Value less Basis for unsold shares" |
| Total Gain | "Realized Gain + Unrealized Gain" |
| Rate of Gain | "Total Gain / Money In * 100 (from GnuCash 2.6.1 onwards)" |
| Income | "Total of all income transactions associated with a stock account." See notes below. |
| Brokerage Fees | Brokerage fees |
| Total Return | "Total Gain + Income" |
| Rate of Return | "Total Return / Money In * 100" |

Notes on Income from the manual:

- For dividends that are not reinvested, a dummy split in the stock account
  (quantity 0, price 1, value 0) ties the income transaction to the stock.
- Since GnuCash 2.6.6 (commits `13abe849e` and `383d16609`), the report also
  finds income/expense transactions from the stock's *parent* account to an
  income or expense account whose name matches the stock account's name. One
  example is `Assets:Broker` ↔ `Income:Dividends:Widget Stock`. The transaction
  must have exactly two splits, not counting trading-account splits. The
  manual says this "will not work if the income or expense account split is to
  a subaccount of the account with the same name as the stock account."

The manual is older than `df6c77561` (2023), which adds sale brokerage fees
to Money Out unless fees are ignored. The current test expectations reflect
that change.

## Options (Manual)

| Tab | Option | Values (default first) |
|---|---|---|
| General | Date | report date (code option; not in the manual's table) |
| General | Report's currency | (code option; not in the manual's table) |
| Accounts | Accounts | stock/mutual accounts to report on (code option) |
| Accounts | Include accounts with no shares | unchecked / checked |
| Display | Show ticker symbols | checked |
| Display | Show listings | checked |
| Display | Show number of shares | checked |
| Display | Share decimal places | 2 (max 9 since `8ffede531`) |
| Display | Show prices | checked |
| General | Price Source | Nearest in time / Most Recent |
| General | Basis calculation method | Average / FIFO / LIFO |
| General | Set preference for price list data | checked: use the price list and fall back to transaction prices with a warning. Unchecked: use prices from stock transactions. |
| General | How to report brokerage fees | Include in basis / Include in gain / Ignore |

Notes on how the code differs:

- The option symbols are `pricedb-nearest`, `pricedb-latest`,
  `average-basis`, `fifo-basis` and `filo-basis`. LIFO keeps its old internal
  name `filo-basis` so saved reports still work (`916ad28fc`). The brokerage
  symbols are `include-in-basis`, `include-in-gain` and `ignore-brokerage`.
- `9c87585d4` (2023-02, Bug 798747) added a `pricedb-before` branch to the
  price lookup. It uses the nearest price on or before the report date. The
  option itself still offers only `pricedb-latest` and `pricedb-nearest`
  (`options-generator` in `advanced-portfolio.scm`), so users cannot pick
  that branch from the Price Source menu.
- An earlier "latest before" price source was removed in `dd1dde78a` (2014)
  because it had never been implemented.
- The code's warning footnotes: `*` means the data was built from transaction
  pricing rather than the price list; `**` means the commodity has no price
  and a price of 1 was used.

## Investment Portfolio (sibling report)

> The Investment Portfolio produces a report of commodity accounts (that is,
> accounts with type "Stock" or "Mutual Fund"), giving holdings, price and value
> information about commodities in the file.

This is `portfolio.scm`, which is not included here. `test-portfolios.scm`
covers both reports.
