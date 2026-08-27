# Action button/link

Action button/link

## Usage

``` r
actionButton(
  inputId,
  label,
  icon = NULL,
  width = NULL,
  ...,
  status = NULL,
  outline = FALSE,
  size = NULL,
  flat = FALSE
)
```

## Arguments

- inputId:

  The input slot used to access the value.

- label:

  Button label.

- icon:

  Optional icon.

- width:

  Button width.

- ...:

  Named attributes applied to the button.

- status:

  Bootstrap status color.

- outline:

  Whether to display an outline style.

- size:

  Button size.

- flat:

  Whether to apply a flat style.

## Examples

``` r
actionButton(
  inputId = "refresh",
  label = "Refresh",
  icon = "arrow-clockwise",
  status = "primary"
)
#> <button class="btn btn-default action-button btn-primary" id="refresh" type="button"><span class="icon-missing" title="Unknown icon: arrow-clockwise" role="img" aria-label="Unknown icon: arrow-clockwise">?</span><span class="action-label">Refresh</span></button>
```
