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
icon("user")
icon("bar-chart", class = "text-primary", size = "1.25rem")
#> <span style="font-size:1.25rem;"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" class="bi bi-bar-chart text-primary" style="height:1em;width:1em;fill:currentColor;vertical-align:-0.125em;" aria-hidden="true" role="img" ><path d="M4 11H2v3h2v-3zm5-4H7v7h2V7zm5-5v12h-2V2h2zm-2-1a1 1 0 0 0-1 1v12a1 1 0 0 0 1 1h2a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1h-2zM6 7a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1v7a1 1 0 0 1-1 1H7a1 1 0 0 1-1-1V7zm-5 4a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1v3a1 1 0 0 1-1 1H2a1 1 0 0 1-1-1v-3z"></path></svg></span>
```
