# Notes for the next CRAN release

This file tracks documentation/positioning ideas that were deliberately
**not** applied to `DESCRIPTION` in the current release because a CRAN
submission for `0.7.5` is already in progress. Apply them the next time
the version is bumped.

## Suggested future `Description` wording

The current `DESCRIPTION` `Description:` field is accurate but doesn't
lead with the package's primary use case (dashboard-style sidebar
navigation) or name the underlying stack, which makes the package
harder to find via CRAN/search-engine search. Consider adopting wording
close to:

> Provides dashboard-style sidebar navigation components for Shiny
> applications built with 'bslib' and Bootstrap 5, including sidebar
> menus, nested navigation, badges, and tab-oriented dashboard layouts.

This keeps the same technical claims as the current field (bslib +
Bootstrap 5, sidebar navigation, dashboard page shell) but foregrounds
"sidebar navigation" and "dashboard" earlier, which are the terms
developers most often search for.

## Suggested future `Title` wording

Consider whether `Title` should mention "sidebar navigation" explicitly,
e.g. `"Dashboard Sidebar Navigation for Shiny Apps with 'bslib'"`, subject
to CRAN's Title-field conventions (title case, no package name, <= 65
characters).

## Why this wasn't done now

- Changing `DESCRIPTION` while a submission is under CRAN review risks
  triggering a re-review or confusing the incoming-checks diff.
- None of the current-release documentation/pkgdown changes required a
  `DESCRIPTION`, `NAMESPACE`, or API change, so they are safe to ship on
  the development branch ahead of the next release.
