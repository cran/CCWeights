source("helpers.R")
source("themes.R")

bs4DashPage(
  old_school = FALSE,
  sidebar_min = TRUE,
  sidebar_collapsed = FALSE,
  controlbar_collapsed = TRUE,
  controlbar_overlay = TRUE,
  title = "CCWeights",

  ## NAVBAR ----------------------------------------------------------------------

  bs4DashNavbar(
    skin = "dark",
    status = "primary",
    border = TRUE,
    sidebarIcon = "chevron-left",
    controlbarIcon = "th",
    fixed = FALSE
    ),

  ## SIDEBAR ----------------------------------------------------------------------

  bs4DashSidebar(
    skin = "dark",
    status = "warning",
    title = HTML("<b>CCWeights</b>"),
    brandColor = "warning",
    src = "https://github.com/YonghuiDong/CCWeights/blob/main/inst/shiny/Gui/mds/pix/logo.png?raw=true",
    elevation = 3,
    opacity = 0.8,

    bs4SidebarMenu(

      bs4SidebarMenuItem("Home", tabName = "home", icon = "home"),
      bs4SidebarMenuItem("Upload Data", tabName = "inputdata", icon = "upload"),
      bs4SidebarMenuItem("Homoscedasticity Test", tabName = "homoscedasticity", icon = "check"),
      bs4SidebarMenuItem("Weights Test", tabName = "weights", icon = "balance-scale"),
      bs4SidebarMenuItem("Calibration", tabName = "calibration", icon = "chart-bar"),
      bs4SidebarMenuItem("Contact", tabName = "contact", icon = "user")
      )
    ),

  ## BODY ----------------------------------------------------------------------

  bs4DashBody(

    use_theme(my_theme),

    bs4TabItems(

      bs4TabItem("home",
                 source("ui-tab-landing.R", local=TRUE)$value),
      bs4TabItem("inputdata",
                 source("ui-tab-inputdata.R", local=TRUE)$value),
      bs4TabItem("homoscedasticity",
                 source("ui-tab-homoscedasticity.R", local=TRUE)$value),
      bs4TabItem("weights",
                 source("ui-tab-weights.R", local=TRUE)$value),
      bs4TabItem("calibration",
                 source("ui-tab-calibration.R", local=TRUE)$value),
      bs4TabItem("contact",
                 source("ui-tab-contact.R", local=TRUE)$value)
      ) # bs4TabItems
    ), # bs4DashBody

  ## FOOTER ----------------------------------------------------------------------

  bs4DashFooter(

    fluidRow(
      column(
        width = 12,
        align = "center",
        "Blavatnic Center for Drug Discovery (BCDD)",
        br(),
        "Tel Aviv University",
        br(),
        "Copyright (C) 2021, code licensed under GPL-3.0",
        br()
        )
      ),
    right_text = NULL
    )
  ) # bs4DashPage

