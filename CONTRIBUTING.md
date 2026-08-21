# Contributing to bslibdash

Thanks for taking the time to help improve bslibdash! This document
outlines how to file issues and propose changes.

## Filing issues

Before opening a new issue, please search the existing issues to make
sure your problem or idea has not already been reported.

When reporting a bug, please include a small, self-contained
[reprex](https://reprex.tidyverse.org/) that reproduces the problem.
Reprexes make it much faster for us to understand and fix issues.

Include, at minimum:

- A short description of what you expected vs. what happened.
- The bslibdash version (`packageVersion("bslibdash")`) and the output
  of `sessionInfo()` or `devtools::session_info()`.
- The smallest possible Shiny app or code snippet that shows the issue.

For feature requests, describe the use case first (what you are trying
to accomplish) before jumping to a specific API suggestion.

## Fixing typos

Small typo fixes in documentation may be edited directly through the
GitHub web interface, as long as the change is made in the source file
(usually a roxygen comment in an `.R` file under `R/`) and **not** in
the generated `.Rd` file under `man/`.

## Pull requests

Before you invest time in a substantial change, please open an issue to
discuss the approach. That way we can make sure it is a good fit for
the package and avoid duplicated effort.

For any pull request:

1. Fork the repository and create a feature branch off `main`.
2. Install the development dependencies: `devtools::install_dev_deps()`.
3. Make your changes together with tests and documentation.
4. Run `devtools::document()` if you changed any roxygen comments, and
   commit the regenerated `man/` and `NAMESPACE` files.
5. Run `devtools::test()` and `devtools::check()` locally and make sure
   both pass without new warnings or notes.
6. Push the branch and open a pull request. Reference the related
   issue in the description.

## Code style

- Follow the [tidyverse style guide](https://style.tidyverse.org/).
- The project uses [lintr](https://lintr.r-lib.org/) — run
  `lintr::lint_package()` before submitting.
- Please avoid mixing unrelated changes (formatting, refactors, feature
  work) in the same pull request.

## Tests

- New behaviour should be covered by tests in `tests/testthat/`.
- Bug fixes should include a regression test that fails before your
  fix and passes after it.
- Snapshot tests (`testthat::expect_snapshot()`) are welcome for HTML
  output; commit the resulting `_snaps/` files.

## Documentation

- User-facing changes should be documented in `NEWS.md` under a
  `# bslibdash (development version)` heading.
- Public functions must have complete roxygen documentation, including
  `@param`, `@return`, and at least one runnable `@examples` block.
