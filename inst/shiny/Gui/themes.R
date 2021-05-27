my_theme <- create_theme(

  # navbar

  bs4dash_vars(
    navbar_dark_color = "#FFFFFF",
    navbar_dark_active_color = "#F17F42",
    navbar_dark_hover_color = "#F17F42"
  ),

  # main bg

  bs4dash_layout(
    main_bg = "#FFFFFF"
  ),

  # sidebar

  bs4dash_sidebar_dark(
    bg = "#9DC8C8",
    color = "#FFFFFF",
    hover_color = "#F17F42",
    active_color = "000000",

    # submenu

    submenu_bg = "#9DC8C8",
    submenu_active_color = "#000000",
    submenu_active_bg = "#F17F42",
    submenu_color = "#FFFFFF",
    submenu_hover_color = "#F17F42"
  ),

  # status

  bs4dash_status(
    primary = "#9DC8C8", warning = "#F17F42"
  )
)

