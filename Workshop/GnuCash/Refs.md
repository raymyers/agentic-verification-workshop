## **References**

- [Current source: `advanced-portfolio.scm`](https://github.com/Gnucash/gnucash/blob/stable/gnucash/report/reports/standard/advanced-portfolio.scm) — implementation, comments, conditionals, and imported interfaces. [github](https://github.com/Gnucash/gnucash/blob/stable/gnucash/report/reports/standard/advanced-portfolio.scm)
- [Bug #710055](https://bugzilla.gnome.org/show_bug.cgi?id=710055) — reporter’s expected/actual results, attached example book, attached patch, user confirmations, and maintainer discussion. [bugzilla.gnome](https://bugzilla.gnome.org/show_bug.cgi?id=710055)
- [Fix revision announcement: r23310 / r23309](https://lists.gnucash.org/pipermail/gnucash-patches/2013-October/027980.html). [lists.gnucash](https://lists.gnucash.org/pipermail/gnucash-patches/2013-October/027980.html)
- [GnuCash guide: Standard Reports Overview](https://www.gnucash.org/docs/v5/C/gnucash-guide/rpt_standardrpts.html) — Advanced Portfolio documentation. [gnucash](https://www.gnucash.org/docs/v5/C/gnucash-guide/rpt_standardrpts.html)
- [GnuCash 2.2.2 release announcement](https://wiki.gnucash.org/wiki/Announcement_2.2.2) — historical related bug references. [wiki.gnucash](https://wiki.gnucash.org/wiki/Announcement_2.2.2)
- [February 2023 change notification](https://lists.gnucash.org/pipermail/gnucash-changes/2023-February/020246.html) — later changes to the report. [lists.gnucash](https://lists.gnucash.org/pipermail/gnucash-changes/2023-February/020246.html)

Gathered locally (see [README](README.md)): the source and regression tests, including the test fixture builder and the removed 2020 helper tests (`upstream/`), the bug 710055 test book (`fixtures/`), the bug details ([Bug-710055.md](Bug-710055.md)), the docs excerpts ([Docs.md](Docs.md)), and the history across all three file paths ([History.md](History.md)). Also consulted: [GnuCash Manual: Report classes](https://www.gnucash.org/docs/v5/C/gnucash-manual/report-classes.html), which defines the columns and options.

Not yet inspected directly: engine/API contracts used by the report (e.g. `gnc-pricedb-lookup-*`, `xaccSplitGetSharePrice`, commodity collectors).
