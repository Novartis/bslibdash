# Dropdown menu

Dropdown menu

Message item

Notification item

Task item

## Usage

``` r
dropdownMenu(
  ...,
  type = c("messages", "notifications", "tasks"),
  badgeStatus = "primary",
  icon = NULL,
  headerText = NULL,
  .list = NULL,
  href = NULL
)

messageItem(
  from,
  message,
  icon = shiny::icon("user"),
  time = NULL,
  href = NULL,
  image = NULL,
  color = "secondary",
  inputId = NULL
)

notificationItem(
  text,
  icon = bslibdash::icon("exclamation-triangle"),
  status = "success",
  href = NULL,
  inputId = NULL
)

taskItem(text, value = 0, color = "info", href = NULL, inputId = NULL)
```

## Arguments

- ...:

  Menu item tags such as `messageItem()`, `notificationItem()`, or
  `taskItem()`.

- type:

  Dropdown menu type. One of `"messages"`, `"notifications"`, or
  `"tasks"`.

- badgeStatus:

  Bootstrap status color used for the badge count.

- icon:

  Optional custom icon tag.

- headerText:

  Optional text shown at the top of the dropdown panel.

- .list:

  Optional list of menu item tags.

- href:

  Optional URL for the "More" footer link.

- from:

  Who the message is from.

- message:

  Text of the message.

- time:

  Optional message timestamp text.

- image:

  Optional user image URL.

- color:

  Bootstrap status color used for item accents.

- inputId:

  Optional id to make the item behave like an action button.

- text:

  Item text.

- status:

  Bootstrap status color used for the icon.

- value:

  Percent completion value.

## Examples

``` r
dropdownMenu(
  type = "notifications",
  badgeStatus = "warning",
  notificationItem("Backup completed", status = "success"),
  notificationItem("New deployment", status = "info")
)
#> <div class="nav-item dropdown bslibdash-dropdown-menu bslibdash-dropdown-menu-notifications">
#>   <a class="nav-link px-2 py-1 bslibdash-dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
#>     <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" class="bi bi-bell " style="height:1em;width:1em;fill:currentColor;vertical-align:-0.125em;" aria-hidden="true" role="img" ><path d="M8 16a2 2 0 0 0 2-2H6a2 2 0 0 0 2 2zM8 1.918l-.797.161A4.002 4.002 0 0 0 4 6c0 .628-.134 2.197-.459 3.742-.16.767-.376 1.566-.663 2.258h10.244c-.287-.692-.502-1.49-.663-2.258C12.134 8.197 12 6.628 12 6a4.002 4.002 0 0 0-3.203-3.92L8 1.917zM14.22 12c.223.447.481.801.78 1H1c.299-.199.557-.553.78-1C2.68 10.2 3 6.88 3 6c0-2.42 1.72-4.44 4.005-4.901a1 1 0 1 1 1.99 0A5.002 5.002 0 0 1 13 6c0 .88.32 4.2 1.22 6z"></path></svg>
#>     <span class="badge rounded-pill bslibdash-dropdown-badge bg-warning">2</span>
#>   </a>
#>   <div class="dropdown-menu dropdown-menu-end shadow-sm bslibdash-dropdown-menu-panel">
#>     <span class="dropdown-item dropdown-header bslibdash-dropdown-header">You have 2 notifications</span>
#>     <div class="dropdown-divider"></div>
#>     <a class="dropdown-item bslibdash-dropdown-item d-flex align-items-center gap-2" href="#">
#>       <span class="text-success"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" class="bi bi-exclamation-triangle " style="height:1em;width:1em;fill:currentColor;vertical-align:-0.125em;" aria-hidden="true" role="img" ><path d="M7.938 2.016A.13.13 0 0 1 8.002 2a.13.13 0 0 1 .063.016.146.146 0 0 1 .054.057l6.857 11.667c.036.06.035.124.002.183a.163.163 0 0 1-.054.06.116.116 0 0 1-.066.017H1.146a.115.115 0 0 1-.066-.017.163.163 0 0 1-.054-.06.176.176 0 0 1 .002-.183L7.884 2.073a.147.147 0 0 1 .054-.057zm1.044-.45a1.13 1.13 0 0 0-1.96 0L.165 13.233c-.457.778.091 1.767.98 1.767h13.713c.889 0 1.438-.99.98-1.767L8.982 1.566z"></path>
#> <path d="M7.002 12a1 1 0 1 1 2 0 1 1 0 0 1-2 0zM7.1 5.995a.905.905 0 1 1 1.8 0l-.35 3.507a.552.552 0 0 1-1.1 0L7.1 5.995z"></path></svg></span>
#>       <span>Backup completed</span>
#>     </a>
#>     <div class="dropdown-divider"></div>
#>     <a class="dropdown-item bslibdash-dropdown-item d-flex align-items-center gap-2" href="#">
#>       <span class="text-info"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" class="bi bi-exclamation-triangle " style="height:1em;width:1em;fill:currentColor;vertical-align:-0.125em;" aria-hidden="true" role="img" ><path d="M7.938 2.016A.13.13 0 0 1 8.002 2a.13.13 0 0 1 .063.016.146.146 0 0 1 .054.057l6.857 11.667c.036.06.035.124.002.183a.163.163 0 0 1-.054.06.116.116 0 0 1-.066.017H1.146a.115.115 0 0 1-.066-.017.163.163 0 0 1-.054-.06.176.176 0 0 1 .002-.183L7.884 2.073a.147.147 0 0 1 .054-.057zm1.044-.45a1.13 1.13 0 0 0-1.96 0L.165 13.233c-.457.778.091 1.767.98 1.767h13.713c.889 0 1.438-.99.98-1.767L8.982 1.566z"></path>
#> <path d="M7.002 12a1 1 0 1 1 2 0 1 1 0 0 1-2 0zM7.1 5.995a.905.905 0 1 1 1.8 0l-.35 3.507a.552.552 0 0 1-1.1 0L7.1 5.995z"></path></svg></span>
#>       <span>New deployment</span>
#>     </a>
#>     <div class="dropdown-divider"></div>
#>   </div>
#> </div>

messageItem(
  from = "Ops bot",
  message = "Deployment finished successfully.",
  time = "5 mins ago",
  color = "success"
)
#> <a class="dropdown-item bslibdash-dropdown-item" href="#">
#>   <div class="d-flex align-items-start gap-2 bslibdash-dropdown-message">
#>     <div class="flex-grow-1">
#>       <div class="d-flex align-items-center justify-content-between gap-2">
#>         <span class="fw-semibold bslibdash-dropdown-item-title">Ops bot</span>
#>         <span class="text-success">
#>           <i class="far fa-user" role="presentation" aria-label="user icon"></i>
#>         </span>
#>       </div>
#>       <p class="mb-1 small text-body-secondary">Deployment finished successfully.</p>
#>       <p class="mb-0 small text-muted">
#>         <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" class="bi bi-clock " style="height:1em;width:1em;fill:currentColor;vertical-align:-0.125em;" aria-hidden="true" role="img" ><path d="M8 3.5a.5.5 0 0 0-1 0V9a.5.5 0 0 0 .252.434l3.5 2a.5.5 0 0 0 .496-.868L8 8.71V3.5z"></path>
#> <path d="M8 16A8 8 0 1 0 8 0a8 8 0 0 0 0 16zm7-8A7 7 0 1 1 1 8a7 7 0 0 1 14 0z"></path></svg>
#>         <span class="ms-1">5 mins ago</span>
#>       </p>
#>     </div>
#>   </div>
#> </a>
#> <div class="dropdown-divider"></div>

notificationItem(
  text = "3 new alerts",
  status = "danger"
)
#> <a class="dropdown-item bslibdash-dropdown-item d-flex align-items-center gap-2" href="#">
#>   <span class="text-danger"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" class="bi bi-exclamation-triangle " style="height:1em;width:1em;fill:currentColor;vertical-align:-0.125em;" aria-hidden="true" role="img" ><path d="M7.938 2.016A.13.13 0 0 1 8.002 2a.13.13 0 0 1 .063.016.146.146 0 0 1 .054.057l6.857 11.667c.036.06.035.124.002.183a.163.163 0 0 1-.054.06.116.116 0 0 1-.066.017H1.146a.115.115 0 0 1-.066-.017.163.163 0 0 1-.054-.06.176.176 0 0 1 .002-.183L7.884 2.073a.147.147 0 0 1 .054-.057zm1.044-.45a1.13 1.13 0 0 0-1.96 0L.165 13.233c-.457.778.091 1.767.98 1.767h13.713c.889 0 1.438-.99.98-1.767L8.982 1.566z"></path>
#> <path d="M7.002 12a1 1 0 1 1 2 0 1 1 0 0 1-2 0zM7.1 5.995a.905.905 0 1 1 1.8 0l-.35 3.507a.552.552 0 0 1-1.1 0L7.1 5.995z"></path></svg></span>
#>   <span>3 new alerts</span>
#> </a>
#> <div class="dropdown-divider"></div>

taskItem(
  text = "Data refresh",
  value = 75,
  color = "info"
)
#> <a class="dropdown-item bslibdash-dropdown-item" href="#">
#>   <div class="d-flex justify-content-between align-items-center small mb-1">
#>     <span>Data refresh</span>
#>     <span>75%</span>
#>   </div>
#>   <div class="progress bslibdash-dropdown-task-progress" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100">
#>     <div class="progress-bar bg-info" style="width:75%;"></div>
#>   </div>
#> </a>
#> <div class="dropdown-divider"></div>
```
