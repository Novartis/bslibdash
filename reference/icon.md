# Create an bslibdash icon

Create an bslibdash icon

## Usage

``` r
icon(name, class = NULL, style = NULL, size = NULL, color = NULL, css = NULL)
```

## Arguments

- name:

  Name of icon.

- class:

  Additional classes.

- style:

  Optional inline style string or named CSS list.

- size:

  Icon size applied to a wrapping span.

- color:

  Icon color applied to a wrapping span.

- css:

  Named list of CSS properties applied to the icon tag.

## Value

An icon `htmltools` tag.

## Examples

``` r
if (interactive()) {
  icon("user")
  icon("bar-chart", class = "text-primary", size = "1.25rem")
}
```
