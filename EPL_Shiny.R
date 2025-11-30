library(dplyr)
library(shiny)
library(bslib)
library(htmltools)
library(DT)
library(reactable)
library(reactablefmtr)
library(plotly)
library(sparkline)

# Initialize----
source("Data.R", local = TRUE)
source("Definitions.R", local = TRUE)
source("Upcoming_Games.R", local = TRUE)
source("By_Opponents.R", local = TRUE)
source("By_Fixture.R", local = TRUE)
source("Simulation.R", local = TRUE)
source("Simulated_Table.R", local = TRUE)
source("EPL_Table.R", local = TRUE)
source("FDB_Rankings.R", local = TRUE)
source("Fixtures.R", local = TRUE)

# CSS Style----
css_updated <- htmltools::css(text_align = 'right',
                              font_style = 'italic',
                              font_size = '14px',
                              font_weight = 500)
css_title <- htmltools::css(color = 'purple',
                            font_size = '36px',
                            text_align = 'center',
                            font_weight = 600)
css_subtitle <- htmltools::css(color = 'purple',
                               font_size = '20px',
                               text_align = 'center',
                               font_style = 'italic',
                               font_weight = 400)
css_dropdown <- htmltools::css(text_align = 'left',
                               font_style = 'italic',
                               font_size = '14px',
                               font_weight = 0)

# Define UI ----
ui <- 
  bslib::page_navbar(
    navbar_options = bslib::navbar_options(bg = "#1F0026"),
    title = paste0(current_season_full, " English Premier League"),
    
    # UI: Upcoming Games ----
    bslib::nav_panel(title = "Upcoming Games",
                     bslib::layout_sidebar(
                       sidebar = bslib::sidebar(bg = "lightgrey",
                                                shiny::fluidRow(shiny::selectInput(inputId = "upcoming_team",
                                                                                   label = "Team",
                                                                                   choices = epl_teams,
                                                                                   selected = "Liverpool FC",
                                                                                   width = "260px")
                                                )
                       ),
                       htmltools::p(last_updated_text,
                                    style = css_updated),
                       htmltools::h1("Upcoming Fixtures By Team",
                                     style = css_title),
                       reactable::reactableOutput("upcoming_games")
                     )
    ),
    
    # UI: By Opponents----
    bslib::nav_panel(title = "By Opponents",
                     bslib::layout_sidebar(
                       sidebar = bslib::sidebar(bg = "lightgrey",
                                                shiny::fluidRow(shiny::selectInput(inputId = "by_opponent_team",
                                                                                   label = "Team",
                                                                                   choices = epl_teams,
                                                                                   selected = "Liverpool FC",
                                                                                   width = "260px")
                                                )
                       ),
                       htmltools::p(last_updated_text, 
                                    style = css_updated),
                       htmltools::h1(current_season_full, " Results versus Prior Seasons",
                                     style = css_title),
                       reactable::reactableOutput("by_opponent")
                     )
    ),
    
    # UI: By Fixture----
    bslib::nav_panel(title = "By Fixture",
                     bslib::layout_sidebar(
                       sidebar = bslib::sidebar(bg = "lightgrey",
                                                shiny::fluidRow(shiny::selectInput(inputId = "by_fixture_team",
                                                                                   label = "Compare",
                                                                                   choices = epl_teams,
                                                                                   selected = "Liverpool FC",
                                                                                   width = "260px")),
                                                shiny::fluidRow(shiny::selectInput(inputId = "by_fixture_against",
                                                                                   label = "Against",
                                                                                   choices = by_fixture_comp,
                                                                                   selected = "EPL Champions",
                                                                                   width = "260px")),
                                                shiny::fluidRow(shiny::selectInput(inputId = "by_fixture_on",
                                                                                   label = "Based on",
                                                                                   choices = by_fixture_metric,
                                                                                   selected = "Points",
                                                                                   width = "260px")
                                                )
                       ),
                       htmltools::p(last_updated_text, 
                                    style = css_updated),
                       htmltools::h1(current_season_full, " Fixture versus Cohorts",
                                     style = css_title),
                       plotly::plotlyOutput("by_fixture")
                     )
    ),
    
    # UI: Simulation----
    bslib::nav_panel(title = "Simulation",
                     bslib::layout_sidebar(
                       sidebar = bslib::sidebar(bg = "lightgrey",
                                                shiny::fluidRow(selectInput(inputId = "sim_type",
                                                                            label = "Outcome",
                                                                            choices = sims,
                                                                            selected = "EPL Champion",
                                                                            width = "260px")),
                                                shiny::fluidRow(selectInput(inputId = "sim_teams",
                                                                            label = "Teams",
                                                                            choices = sim_teams_winner,
                                                                            selected = sim_teams_winner,
                                                                            multiple = TRUE,
                                                                            width = "260px"),
                                                                htmltools::p("Only teams with probability greater than 3% initially selected",
                                                                             style = css_dropdown)
                                                ),
                                                shiny::fluidRow(selectInput(inputId = "sim_metric",
                                                                            label = "Plot",
                                                                            choices = sim_metrics,
                                                                            selected = "Probability",
                                                                            width = "260px"),
                                                                
                                                )
                       ),
                       htmltools::p(last_updated_text, 
                                    style = css_updated),
                       htmltools::h1("Probability after 1,000 Simulations",
                                     style = css_title),
                       plotly::plotlyOutput("simulation")
                     )
    ),
    
    # UI: Simulated Table----
    bslib::nav_panel(title = "Simulated Table",
                     htmltools::p(last_updated_text, 
                                  style = css_updated),
                     htmltools::h1("Final Standings after 1,000 Simulations",
                                   style = css_title),
                     reactable::reactableOutput("simulated_table")
    ),
    
    # UI: EPL Table----
    bslib::nav_panel(title = "EPL Table",
                     bslib::layout_sidebar(
                       sidebar = bslib::sidebar(bg = "lightgrey",
                                                shiny::fluidRow(selectInput(inputId = "epl_table_season",
                                                                            label = "Season",
                                                                            choices = epl_seasons,
                                                                            selected = current_season_full,
                                                                            width = "260px")
                                                )
                       ),
                       htmltools::p(last_updated_text, 
                                    style = css_updated),
                       htmltools::h1("Premier League Standings",
                                     style = css_title),
                       reactable::reactableOutput("epl_table")
                     )
    ),
    
    # UI: FDB Rankings----
    bslib::nav_panel(title = "FDB Rankings",
                     bslib::layout_sidebar(
                       sidebar = bslib::sidebar(bg = "lightgrey",
                                                shiny::fluidRow(selectInput(inputId = "fd_metric",
                                                                            label = "Plot",
                                                                            choices = fd_metrics,
                                                                            selected = "Points",
                                                                            width = "260px")),
                                                shiny::fluidRow(selectInput(inputId = "fd_team",
                                                                            label = "Teams",
                                                                            choices = epl_teams,
                                                                            selected = top4_teams,
                                                                            multiple = TRUE,
                                                                            width = "260px"), 
                                                                htmltools::p("Only top of table teams initially selected", 
                                                                             style = css_dropdown)
                                                ),
                                                shiny::fluidRow(sliderInput(inputId = "fd_dates",
                                                                            label = "Dates",
                                                                            min = fd_plot_min_date,
                                                                            max = fd_plot_max_date,
                                                                            timeFormat="%b %Y",
                                                                            value = fd_plot_last36)
                                                )
                       ),
                       htmltools::p(last_updated_text, 
                                    style = css_updated),
                       htmltools::h1("footballdatabase.com: Points and Rank", 
                                     style = css_title),
                       plotly::plotlyOutput("fdb_rank")
                     )
    ),
    
    # UI: Fixtures----
    bslib::nav_panel(title = paste0(current_season_full, " Fixtures"),
                     bslib::layout_sidebar(
                       sidebar = bslib::sidebar(bg = "lightgrey",
                                                shiny::fluidRow(selectInput(inputId = "fixture_type",
                                                                            label = "Fixtures",
                                                                            choices = fixture_types,
                                                                            selected = "Upcoming",
                                                                            width = "260px")
                                                )
                       ),
                       htmltools::p(last_updated_text, 
                                    style = css_updated),
                       htmltools::h1(paste0(current_season_full, 
                                            " Fixtures: English Premier League, Domestic and European Cups"), 
                                     style = css_title),
                       htmltools::p("All times Pacific",
                                    style = css_subtitle),
                       DT::dataTableOutput("fixtures")
                     )
    ),
    
    # UI: Links----
    bslib::nav_spacer(),
    bslib::nav_menu(
      title = "Links",
      align = "right",
      bslib::nav_item(tags$a(paste0(current_season_full, " Premier League"),
                             href = "https://www.premierleague.com/en/matches?competition=8&season=2025",
                             target = "_blank")),
      bslib::nav_item(tags$a(paste0(current_season_full, " FA Cup"),
                             href = paste0("https://en.wikipedia.org/wiki/", current_season_full, "_FA_Cup"),
                             target = "_blank")),
      bslib::nav_item(tags$a(paste0(current_season_full, " EFL Cup"),
                             href = paste0("https://en.wikipedia.org/wiki/", current_season_full, "_EFL_Cup"),
                             target = "_blank")),
      bslib::nav_item(tags$a(paste0(current_season_full, " UEFA Champions League"),
                             href = paste0("https://en.wikipedia.org/wiki/", current_season_full, "_UEFA_Champions_League"),
                             target = "_blank")),
      bslib::nav_item(tags$a(paste0(current_season_full, " UEFA Europa League"),
                             href = paste0("https://en.wikipedia.org/wiki/", current_season_full, "_UEFA_Europa_League"),
                             target = "_blank")),
      bslib::nav_item(tags$a(paste0(current_season_full, " UEFA Conference League"),
                             href = paste0("https://en.wikipedia.org/wiki/", current_season_full, "_UEFA_Conference_League"),
                             target = "_blank")),
      bslib::nav_item(tags$a(paste0(substr(current_season_full, 1, 4), " FIFA Club World Cup"),
                             href = paste0("https://en.wikipedia.org/wiki/", substr(current_season_full, 1, 4), "_FIFA_Club_World_Cup"),
                             target = "_blank")),
      bslib::nav_item(tags$a(paste0(substr(current_season_full, 1, 4), " FIFA Intercontinental Cup"),
                             href = paste0("https://en.wikipedia.org/wiki/", substr(current_season_full, 1, 4), "_FIFA_Intercontinental_Cup"),
                             target = "_blank")),
      bslib::nav_item(tags$a("FDB Rankings", 
                             href = 'https://www.footballdatabase.com/clubs-list-country/england',
                             target = "_blank"))
    )
  )

# Define Server----
server <- 
  function(input, output, session) {
    
    # Server: Upcoming Games----
    # https://r-graph-gallery.com/web-interactive-table-with-images-charts-and-more.html
    upcoming_reactive <- shiny::reactive({
      req(input$upcoming_team)
      upcoming_by_team_df %>%
        dplyr::filter(team == input$upcoming_team) %>%
        dplyr::select(-team)
    })
    
    output$upcoming_games <- reactable::renderReactable({
      df <- upcoming_reactive()
      min_spi <- min(df$opponent.spi, na.rm = TRUE) - 100
      max_spi <- max(df$opponent.spi, na.rm = TRUE)
      df$opponent.spi <- ifelse(is.na(df$opponent.spi), 0, df$opponent.spi)
      column_color_style <-
        reactablefmtr::color_scales(df, 
                                    span = which(colnames(df) %in% c("win.prob", "tie.prob", "loss.prob")), 
                                    colors = c("#800101", "#ffcccc", "#cccccc", "#808080", "#cccccc", "#66b266", "#004000"))
      
      reactable::reactable(df,
                           theme = reactable::reactableTheme(borderColor = "#DADADA"),
                           pagination = FALSE,
                           defaultColDef = reactable::colDef(vAlign = "center",
                                                             align = "center",
                                                             headerVAlign = "center",
                                                             style = column_color_style),
                           columnGroups = list(reactable::colGroup(name = "", 
                                                                   columns = c("league.name", "league.style", "date", "league.logo",
                                                                               "date.text", "opponent", "last.result"),
                                                                   align = "left"),
                                               reactable::colGroup(name = "from footballdatabase.com:", 
                                                                   columns = c("team.spi", "opponent.spi", "bar.color"),
                                                                   align = "left"),
                                               reactable::colGroup(name = "Modeled Outcome:", 
                                                                   columns = c("score", "win.prob", "tie.prob", "loss.prob"),
                                                                   align = "left")
                           ),
                           columns = list(league.name = reactable::colDef(show = FALSE),
                                          league.style = reactable::colDef(show = FALSE),
                                          date = reactable::colDef(show = FALSE),
                                          league.logo = reactable::colDef(name = "",
                                                                          align = "center",
                                                                          width = 60,
                                                                          cell = function(value, index) {
                                                                            image <- img(src = value, 
                                                                                         style = df$league.style[index], 
                                                                                         alt = value)
                                                                          }),
                                          date.text = reactable::colDef(name = "Date", 
                                                                        width = 260),
                                          opponent = reactable::colDef(name = "Opponent (Last Result)", 
                                                                       width = 280,
                                                                       cell = function(value, index) {
                                                                         lr <- df$last.result[index]
                                                                         spi <- df$opponent.spi[index]
                                                                         if (spi == 0) {
                                                                           tagList(div(style = "vertical-align:middle;", value)) 
                                                                         } else {
                                                                           tagList(div(style = "vertical-align:middle;", value), 
                                                                                   div(style = "vertical-align:middle;font-size:10pt;color:#8C8C8C;", 
                                                                                       paste0("(", lr, ")"))) 
                                                                         } 
                                                                       }),
                                          last.result = reactable::colDef(show = FALSE),
                                          team.spi = reactable::colDef(show = FALSE),
                                          opponent.spi = reactable::colDef(name = paste0("Opponent Strength (vs ", 
                                                                                         scales::comma(mean(df$team.spi, na.rm = TRUE), 
                                                                                                       accuracy = 1),
                                                                                         ")"),
                                                                           width = 400,
                                                                           class = "border-left",
                                                                           align = "left",
                                                                           cell = reactablefmtr::data_bars(df,
                                                                                                           fill_color_ref = "bar.color",
                                                                                                           text_position = "outside-end",
                                                                                                           bar_height = 45,
                                                                                                           text_size = 16,
                                                                                                           min_value = min_spi,
                                                                                                           max_value = max_spi,
                                                                                                           number_fmt = scales::comma,
                                                                                                           background = "transparent")
                                          ),
                                          bar.color = reactable::colDef(show = FALSE),
                                          score = reactable::colDef(name = "Score",
                                                                    style = list(fontWeight = "bold")),
                                          win.prob = reactable::colDef(name = "Win %",
                                                                       format = reactable::colFormat(percent = TRUE, digits = 1)),
                                          tie.prob = reactable::colDef(name = "Draw %",
                                                                       format = reactable::colFormat(percent = TRUE, digits = 1)),
                                          loss.prob = reactable::colDef(name = "Loss %",
                                                                        format = reactable::colFormat(percent = TRUE, digits = 1))
                           )
      )
    })
    
    # Server: By Opponents----
    by_opponent_reactive <- shiny::reactive({
      req(input$by_opponent_team)
      by_opponent_df %>%
        dplyr::filter(team == input$by_opponent_team) %>%
        dplyr::select(-team, -last.game.ind)
    })
    
    output$by_opponent <- reactable::renderReactable({
      df <- by_opponent_reactive()
      pt_palette <- c("#800101", "#8C8C8C", "#004000")
      gf_palette <- c("#66b266", "#004000")
      ga_palette <- c("#bf8080", "#800101")
      points_scale <- reactablefmtr::color_scales(df, span = 3:7, colors = pt_palette)
      gf_scale <- reactablefmtr::color_scales(df, span = 8:12, colors = gf_palette)
      ga_scale <- reactablefmtr::color_scales(df, span = 13:17, colors = ga_palette)
      reactable::reactable(df,
                           theme = reactable::reactableTheme(borderColor = "#DADADA"),
                           pagination = FALSE,
                           defaultColDef = reactable::colDef(vAlign = "center",
                                                             align = "center",
                                                             headerVAlign = "center",
                                                             width = 75),
                           columnGroups = list(reactable::colGroup(name = "",
                                                                   columns = c("game.number", "opponent"),
                                                                   align = "left"),
                                               reactable::colGroup(name = "Points:",
                                                                   columns = paste0("points.", seq(5)),
                                                                   align = "left"),
                                               reactable::colGroup(name = "Goals Scored:",
                                                                   columns = paste0("goals.scored.", seq(5)),
                                                                   align = "left"),
                                               reactable::colGroup(name = "Goals Conceded:",
                                                                   columns = paste0("goals.conceded.", seq(5)),
                                                                   align = "left")),
                           columns = list(game.number = reactable::colDef(show = FALSE),
                                          opponent = reactable::colDef(name = 'Opponent', 
                                                                       width = 230,
                                                                       style = function(value, index) {
                                                                         opp <- df$opponent[index]
                                                                         if (opp == "All Opponents") {
                                                                           font <- "bold"
                                                                           bg <- "#cccccc"
                                                                         } else {
                                                                           font <- "normal"
                                                                           bg <- "white"
                                                                         }
                                                                         list(fontWeight = font,
                                                                              background = bg)}),
                                          points.1 = reactable::colDef(name = last5_seasons[1], style = points_scale),
                                          points.2 = reactable::colDef(name = last5_seasons[2], style = points_scale),
                                          points.3 = reactable::colDef(name = last5_seasons[3], style = points_scale),
                                          points.4 = reactable::colDef(name = last5_seasons[4], style = points_scale),
                                          points.5 = reactable::colDef(name = last5_seasons[5], style = points_scale),
                                          goals.scored.1 = reactable::colDef(name = last5_seasons[1], style = gf_scale),
                                          goals.scored.2 = reactable::colDef(name = last5_seasons[2], style = gf_scale),
                                          goals.scored.3 = reactable::colDef(name = last5_seasons[3], style = gf_scale),
                                          goals.scored.4 = reactable::colDef(name = last5_seasons[4], style = gf_scale),
                                          goals.scored.5 = reactable::colDef(name = last5_seasons[5], style = gf_scale),
                                          goals.conceded.1 = reactable::colDef(name = last5_seasons[1], style = ga_scale),
                                          goals.conceded.2 = reactable::colDef(name = last5_seasons[2], style = ga_scale),
                                          goals.conceded.3 = reactable::colDef(name = last5_seasons[3], style = ga_scale),
                                          goals.conceded.4 = reactable::colDef(name = last5_seasons[4], style = ga_scale),
                                          goals.conceded.5 = reactable::colDef(name = last5_seasons[5], style = ga_scale)
                           )
      )
    })
    
    # Server: By Fixture----
    by_fixture_reactive <- shiny::reactive({
      req(input$by_fixture_team)
      req(input$by_fixture_against)
      req(input$by_fixture_on)
      # Current season
      team_df <-
        against_current_df %>%
        dplyr::filter(team == input$by_fixture_team &
                        metric.name == input$by_fixture_on)
      # Compare against
      if (input$by_fixture_against == "Last 5 Seasons") {
        df <- 
          against_all_cohorts_df %>%
          dplyr::filter(team == input$by_fixture_team &
                          against == input$by_fixture_against & 
                          metric.name == input$by_fixture_on) %>%
          dplyr::left_join(team_df, by = 'fixture')
      } else {
        df <- 
          against_all_cohorts_df %>%
          dplyr::filter(against == input$by_fixture_against & 
                          metric.name == input$by_fixture_on) %>%
          dplyr::left_join(team_df, by = 'fixture')
      }
      return(dplyr::select(df, fixture, min, max, avg, metric.running))
    })
    
    output$by_fixture <- plotly::renderPlotly({
      by_fixture_reactive() %>%
        plotly::plot_ly(x = ~fixture,
                        y = ~max, 
                        type = 'scatter',
                        mode = 'lines',
                        hoverinfo = 'text',
                        text = paste0(input$by_fixture_on, " by Fixture ", .$fixture,
                                      "<br><br>", input$by_fixture_against, " High: ", .$max,
                                      "<br>", input$by_fixture_against, " Average: ", .$avg,
                                      "<br>", input$by_fixture_against, " Low: ", .$min,
                                      "<br><br>", current_season_full, " ", input$by_fixture_team, ": ", .$metric.running),
                        line = list(color = 'transparent'),
                        showlegend = FALSE,
                        name = 'High') %>%
        plotly::add_trace(y = ~min, 
                          type = 'scatter',
                          mode = 'lines',
                          fill = 'tonexty',
                          fillcolor = 'rgba(56,31,90,0.2)', 
                          line = list(color = 'transparent'),
                          showlegend = FALSE, 
                          name = 'Low') %>%
        plotly::add_trace(x = ~fixture, 
                          y = ~avg, 
                          type = 'scatter', 
                          mode = 'lines',
                          line = list(color = 'rgb(56,31,90)'),
                          name = 'Average') %>%
        plotly::add_trace(x = ~fixture, 
                          y = ~metric.running, 
                          type = 'scatter', 
                          mode = 'lines',
                          line = list(color = 'rgb(161,40,40)'),
                          name = 'Current Season') %>%
        plotly::layout(title = list(text = paste0(input$by_fixture_team, " 's ", 
                                                  input$by_fixture_on, " against ", input$by_fixture_against),
                                    y = 0.97,
                                    font = list(color = 'black', size = 24)),
                       xaxis = list(title = list(text = 'Fixture',
                                                 font = list(color = 'purple', size = 22)),
                                    tickfont = list(color = 'black', size = 20)),
                       yaxis = list(title = list(text = input$plot_metric,
                                                 font = list(color = 'purple', size = 22)),
                                    tickfont = list(color = 'black', size = 20)
                       )
        )
    })
    
    # Server Simulation----
    shiny::observe({
      shiny::updateSelectInput(session = session,
                               inputId = "sim_teams",
                               choices = epl_teams,
                               selected = switch(input$sim_type,
                                                 "EPL Champion" = sim_teams_winner,
                                                 "Champions League Qualification" = sim_teams_ucl,
                                                 "Europa League Qualification" = sim_teams_europa,
                                                 "EPL Relegation" = sim_teams_rel))
    })
    
    simulation_reactive <- shiny::reactive({
      req(input$sim_type)
      req(input$sim_teams)
      req(input$sim_metric)
      simulation_ts_df %>%
        dplyr::filter(sim.metric == input$sim_metric) %>%
        dplyr::filter(grepl(input$sim_type, sim.type)) %>%
        dplyr::filter(team %in% input$sim_teams) 
    })
    
    output$simulation <- plotly::renderPlotly({
      req(input$sim_metric)
      df <- simulation_reactive()
      if (input$sim_metric == "Probability") {
        df$y_label <- scales::percent(df$y, acccuracy = .01)
        plot_ymax <- 1
        plot_tick <- ".0%"
      } else if (input$sim_metric == "Expected Points") {
        df$y_label <- scales::comma(round(df$y, 1), acccuracy = .1)
        plot_ymax <- max(100, round(max(df$y), 1) + 5)
        plot_tick <- ".0f"
      }
      df %>%
        plotly::plot_ly(x = ~sim.date,
                        y = ~y,
                        color = ~team,
                        colors = unique(df$team.color),
                        type = "scatter",
                        mode = 'lines+markers',
                        hoverinfo = 'text',
                        text = paste0(input$sim_type,
                                      "<br><br>", .$team, " ", tolower(input$sim_metric) ," as of ", .$sim.date, ":",
                                      "<br>", .$y_label)) %>%
        plotly::add_trace(x = ~sim.date + 2,
                          y = ~y,
                          type = 'scatter',
                          mode = 'text',
                          text = ~text,
                          textposition = 'right',
                          textfont = list(size = 16),
                          showlegend = FALSE,
                          hoverinfo = 'none') %>%
        plotly::layout(title = list(text = input$sim_type,
                                    y = 0.97,
                                    font = list(color = 'black', size = 24)),
                       showlegend = FALSE,
                       shapes =   list(type = "rect",
                                       fillcolor = "#660180",
                                       opacity = 0.2,
                                       y0 = 0,
                                       y1 = plot_ymax,
                                       #yref = "paper",
                                       x0 = epl_season_end,
                                       x1 = epl_season_end + 15,
                                       line = list(color = "#660180")),
                       #plot_bgcolor = "#e5ecf6",
                       yaxis = list(title = list(text = input$sim_metric,
                                                 font = list(color = 'purple', size = 22)),
                                    tickformat = plot_tick,
                                    range = c(0, plot_ymax),
                                    tickfont = list(color = 'black', size = 20)),
                       xaxis = list(title = list(text = 'Date',
                                                 font = list(color = 'purple', size = 22)),
                                    tickformat = "%b",
                                    range = c(sim_start_date - 5, epl_season_end + 15),
                                    tickfont = list(color = 'black', size = 20)
                       )
        )
    })
    
    # Server: Simulated Table----
    output$simulated_table <- reactable::renderReactable({
      color_style_win <- reactablefmtr::color_scales(sim_table_df,
                                                     span = which(colnames(sim_table_df) == "winner"),
                                                     colors = c("#d8b2d8", "#660180"))
      color_style_ucl <- reactablefmtr::color_scales(sim_table_df,
                                                     span = which(colnames(sim_table_df) == "ucl"),
                                                     colors = c("#b2b2b2", "#323232"))
      color_style_rel <- reactablefmtr::color_scales(sim_table_df,
                                                     span = which(colnames(sim_table_df) == "relegated"),
                                                     colors = c("#bf8080", "#800101"))
      
      sim_table_df %>%
        reactable::reactable(theme = reactable::reactableTheme(borderColor = "#DADADA"),
                             pagination = FALSE,
                             defaultColDef = reactable::colDef(vAlign = "center",
                                                               align = "center",
                                                               headerVAlign = "center"),
                             columnGroups = list(reactable::colGroup(name = "",
                                                                     columns = colnames(sim_table_df),
                                                                     align = "left")
                             ),
                             columns = list(rel.ind = reactable::colDef(show = FALSE),
                                            cup.color = reactable::colDef(show = FALSE),
                                            position = reactable::colDef(name = '',
                                                                         width = 40,
                                                                         style = function(value, index) {
                                                                           list(background = sim_table_df$cup.color[index])}),
                                            team.logo = reactable::colDef(name = "Team",
                                                                          align = "center",
                                                                          cell = function(value, index) {
                                                                            image <-
                                                                              img(src = value,
                                                                                  style = sim_table_df$team.style[index],
                                                                                  alt = value)},
                                                                          width = 60,
                                                                          style = function(value, index) {
                                                                            list(background = sim_table_df$cup.color[index])}
                                            ),
                                            team.style = reactable::colDef(show = FALSE),
                                            team = reactable::colDef(name = "",
                                                                     align = "left",
                                                                     width = 270,
                                                                     style = function(value, index) {
                                                                       list(background = sim_table_df$cup.color[index])}
                                            ),
                                            cup.logo = reactable::colDef(name = '',
                                                                         width = 50,
                                                                         cell = function(value, index) {
                                                                           if (!is.na(value)) {
                                                                             image <- img(src = value, 
                                                                                          style = sim_table_df$cup.style[index],
                                                                                          alt = value)
                                                                           }
                                                                         },
                                                                         style = function(value, index) {
                                                                           list(background = sim_table_df$cup.color[index])}),
                                            cup.style = reactable::colDef(show = FALSE),
                                            games.played = reactable::colDef(name = 'Games Played',
                                                                             style = function(value, index) {
                                                                               list(background = sim_table_df$cup.color[index])}
                                            ),
                                            games.sim = reactable::colDef(name = 'Games Simulated',
                                                                          style = function(value, index) {
                                                                            list(background = sim_table_df$cup.color[index])}
                                            ),
                                            wins = reactable::colDef(name = 'W',
                                                                     width = 90,
                                                                     style = function(value, index) {
                                                                       list(background = sim_table_df$cup.color[index])}
                                            ),
                                            draws = reactable::colDef(name = 'D',
                                                                      width = 90,
                                                                      style = function(value, index) {
                                                                        list(background = sim_table_df$cup.color[index])}
                                            ),
                                            losses = reactable::colDef(name = 'L',
                                                                       width = 90,
                                                                       style = function(value, index) {
                                                                         list(background = sim_table_df$cup.color[index])}
                                            ),
                                            gf = reactable::colDef(name = 'GF',
                                                                   width = 90,
                                                                   style = function(value, index) {
                                                                     list(background = sim_table_df$cup.color[index])}
                                            ),
                                            ga = reactable::colDef(name = 'GA',
                                                                   width = 90,
                                                                   style = function(value, index) {
                                                                     list(background = sim_table_df$cup.color[index])}
                                            ),
                                            gd = reactable::colDef(name = 'GD',
                                                                   style = function(value, index) {
                                                                     if (value < 0) {
                                                                       list(color = "crimson",
                                                                            fontWeight = 'bold',
                                                                            fontSize = '24px',
                                                                            background = sim_table_df$cup.color[index])
                                                                     } else {
                                                                       list(color = "green",
                                                                            fontWeight = 'bold',
                                                                            fontSize = '24px',
                                                                            background = sim_table_df$cup.color[index])
                                                                     }
                                                                   }
                                            ),
                                            points = reactable::colDef(name = 'Points',
                                                                       style = function(value, index) {
                                                                         list(fontWeight = 'bold',
                                                                              fontSize = '24px',
                                                                              background = sim_table_df$cup.color[index])}
                                            ),
                                            sparkline = reactable::colDef(name = "Final Position",
                                                                          cell = function(value, index) {
                                                                            sparkline::sparkline(sim_table_df$pos.hist[[index]],
                                                                                                 height = 40)
                                                                          }
                                            ),
                                            pos.hist = reactable::colDef(show = FALSE),
                                            winner = reactable::colDef(name = "Winner %",
                                                                       format = reactable::colFormat(percent = TRUE, digits = 1),
                                                                       style = color_style_win),
                                            ucl = reactable::colDef(name = "UCL %",
                                                                    format = reactable::colFormat(percent = TRUE, digits = 1),
                                                                    style = color_style_ucl),
                                            relegated = reactable::colDef(name = "Relegated %",
                                                                          format = reactable::colFormat(percent = TRUE, digits = 1),
                                                                          style = color_style_rel)
                             )
        )
    })
    
    # Server: EPL Table----
    epl_table_reactive <- shiny::reactive({
      req(input$epl_table_season)
      epl_table_df %>%
        dplyr::filter(season == input$epl_table_season) %>%
        dplyr::arrange(position) %>%
        dplyr::select(-season)
    })
    
    output$epl_table <- reactable::renderReactable({
      req(input$epl_table_season)
      df <- epl_table_reactive()
      base_cols <- c("cup.color", "position", "team.logo", "team.style", "team", "cup.logo", "cup.style", 
                     "games", "wins", "draws", "losses", "gf", "ga", "gd", "points")
      
      if (input$epl_table_season == current_season_full) {
        table_header <- "Table:"
        base_len <- c(99, 40, 60, 99, 270, 50, 99, 
                      70, 50, 50, 50, 50, 50, 60, 70)
      } else {
        table_header <- ""
        base_len <- c(99, 40, 60, 99, 270, 50, NULL, 
                      NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
      }
      
      if (last5_num_games <= 1) {
        lg_len <- 65
      } else {
        lg_len <- 36
      }
      
      cs_excess_ppg <- reactablefmtr::color_scales(df,
                                                   span = which(colnames(df) == "excess.ppg"),
                                                   colors = c("#800101", "#ffcccc", "#808080", "#66b266", "#004000"))
      cs_strength <- reactablefmtr::color_scales(df,
                                                 span = which(colnames(df) == "strength"),
                                                 colors = c("#004000", "#66b266", "#808080", "#ffcccc", "#800101"))
      cs_expected_points <- reactablefmtr::color_scales(df,
                                                        span = which(colnames(df) == "expected.points"),
                                                        colors = c("#800101", "#ffcccc", "#808080", "#66b266", "#004000"))
      cs_strength_upcoming <- reactablefmtr::color_scales(df,
                                                          span = which(colnames(df) == "strength.upcoming"),
                                                          colors = c("#004000", "#66b266", "#808080", "#ffcccc", "#800101"))
      
      df %>%
        reactable::reactable(theme = reactable::reactableTheme(borderColor = "#DADADA"),
                             pagination = FALSE,
                             defaultColDef = reactable::colDef(vAlign = "center",
                                                               align = "center",
                                                               headerVAlign = "center"),
                             columnGroups = list(reactable::colGroup(name = table_header,
                                                                     columns = base_cols,
                                                                     align = "left"),
                                                 reactable::colGroup(name = "Form:",
                                                                     columns = c("lg.1.logo", "lg.2.logo", "lg.3.logo", "lg.4.logo",
                                                                                 "lg.5.logo", "lg.1.style", "lg.2.style", "lg.3.style",
                                                                                 "lg.4.style", "lg.5.style"),
                                                                     align = "left"),
                                                 reactable::colGroup(name = "Last 5 Games:",
                                                                     columns = c("excess.ppg", "strength"),
                                                                     align = "left"),
                                                 reactable::colGroup(name = "Next 5 Games:",
                                                                     columns = c("expected.points", "strength.upcoming"),
                                                                     align = "left")
                             ),
                             columns = list(cup.color = reactable::colDef(show = FALSE),
                                            position = reactable::colDef(name = '',
                                                                         width = base_len[2],
                                                                         style = function(value, index) {
                                                                           list(background = df$cup.color[index])}
                                            ),
                                            team.logo = reactable::colDef(name = "Team",
                                                                          align = "center",
                                                                          width = base_len[3],
                                                                          cell = function(value, index) {
                                                                            img(src = value,
                                                                                style = df$team.style[index],
                                                                                alt = value)
                                                                          },
                                                                          style = function(value, index) {
                                                                            list(background = df$cup.color[index])}
                                            ),
                                            team.style = reactable::colDef(show = FALSE),
                                            team = reactable::colDef(name = "",
                                                                     align = "left",
                                                                     width = base_len[5],
                                                                     style = function(value, index) {
                                                                       list(background = df$cup.color[index])}
                                            ),
                                            cup.logo = reactable::colDef(name = "",
                                                                         align = "center",
                                                                         width = base_len[6],
                                                                         cell = function(value, index) {
                                                                           if (!is.na(value)) {
                                                                             img(src = value,
                                                                                 style = df$cup.style[index],
                                                                                 alt = value)
                                                                           }
                                                                         },
                                                                         style = function(value, index) {
                                                                           list(background = df$cup.color[index])}
                                            ),
                                            cup.style = reactable::colDef(show = FALSE),
                                            games = reactable::colDef(name = 'Games',
                                                                      width = base_len[8],
                                                                      style = function(value, index) {
                                                                        list(fontSize = '18px',
                                                                             background = df$cup.color[index])}
                                            ),
                                            wins = reactable::colDef(name = 'W',
                                                                     width = base_len[9],
                                                                     style = function(value, index) {
                                                                       list(fontSize = '18px',
                                                                            background = df$cup.color[index])}
                                            ),
                                            draws = reactable::colDef(name = 'D',
                                                                      width = base_len[10],
                                                                      style = function(value, index) {
                                                                        list(fontSize = '18px',
                                                                             background = df$cup.color[index])}
                                            ),
                                            losses = reactable::colDef(name = 'L',
                                                                       width = base_len[11],
                                                                       style = function(value, index) {
                                                                         list(fontSize = '18px',
                                                                              background = df$cup.color[index])}
                                            ),
                                            gf = reactable::colDef(name = 'GF',
                                                                   width = base_len[12],
                                                                   style = function(value, index) {
                                                                     list(fontSize = '18px',
                                                                          background = df$cup.color[index])}
                                            ),
                                            ga = reactable::colDef(name = 'GA',
                                                                   width = base_len[13],
                                                                   style = function(value, index) {
                                                                     list(fontSize = '18px',
                                                                          background = df$cup.color[index])}
                                            ),
                                            gd = reactable::colDef(name = 'GD',
                                                                   width = base_len[14],
                                                                   style = function(value, index) {
                                                                     if (value < 0) {
                                                                       list(color = "crimson",
                                                                            background = df$cup.color[index],
                                                                            fontWeight = 'bold',
                                                                            fontSize = '24px')
                                                                     } else {
                                                                       list(color = "green",
                                                                            background = df$cup.color[index],
                                                                            fontWeight = 'bold',
                                                                            fontSize = '24px')
                                                                     }
                                                                   }
                                            ),
                                            points = reactable::colDef(name = 'Points',
                                                                       width = base_len[15],
                                                                       style = function(value, index) {
                                                                         list(fontSize = '24px',
                                                                              fontWeight = 'bold',
                                                                              background = df$cup.color[index])
                                                                       }
                                            ),
                                            lg.1.logo = reactable::colDef(name = "",
                                                                          show = input$epl_table_season == current_season_full &
                                                                            last5_num_games >= 1,
                                                                          width = lg_len,
                                                                          align = "center",
                                                                          cell = function(value, index) {
                                                                            if (!is.na(value)) {
                                                                              image <- img(src = value,
                                                                                           style = df$lg.1.style[index],
                                                                                           alt = value)
                                                                            }
                                                                          },
                                                                          style = function(value, index) {
                                                                            list(background = df$cup.color[index])}
                                            ),
                                            lg.1.style = reactable::colDef(show = FALSE),
                                            lg.2.logo = reactable::colDef(name = "",
                                                                          show = input$epl_table_season == current_season_full &
                                                                            last5_num_games >= 2,
                                                                          width = lg_len,
                                                                          align = "center",
                                                                          cell = function(value, index) {
                                                                            if (!is.na(value)) {
                                                                              image <- img(src = value,
                                                                                           style = df$lg.2.style[index],
                                                                                           alt = value)
                                                                            }
                                                                          },
                                                                          style = function(value, index) {
                                                                            list(background = df$cup.color[index])}
                                            ),
                                            lg.2.style = reactable::colDef(show = FALSE),
                                            lg.3.logo = reactable::colDef(name = "",
                                                                          show = input$epl_table_season == current_season_full &
                                                                            last5_num_games >= 3,
                                                                          width = lg_len,
                                                                          align = "center",
                                                                          cell = function(value, index) {
                                                                            if (!is.na(value)) {
                                                                              image <- img(src = value,
                                                                                           style = df$lg.3.style[index],
                                                                                           alt = value)
                                                                            }
                                                                          },
                                                                          style = function(value, index) {
                                                                            list(background = df$cup.color[index])}
                                            ),
                                            lg.3.style = reactable::colDef(show = FALSE),
                                            lg.4.logo = reactable::colDef(name = "",
                                                                          show = input$epl_table_season == current_season_full &
                                                                            last5_num_games >= 4,
                                                                          width = lg_len,
                                                                          align = "center",
                                                                          cell = function(value, index) {
                                                                            if (!is.na(value)) {
                                                                              image <- img(src = value,
                                                                                           style = df$lg.4.style[index],
                                                                                           alt = value)
                                                                            }
                                                                          },
                                                                          style = function(value, index) {
                                                                            list(background = df$cup.color[index])}
                                            ),
                                            lg.4.style = reactable::colDef(show = FALSE),
                                            lg.5.logo = reactable::colDef(name = "",
                                                                          show = input$epl_table_season == current_season_full &
                                                                            last5_num_games >= 5,
                                                                          width = lg_len,
                                                                          align = "center",
                                                                          cell = function(value, index) {
                                                                            if (!is.na(value)) {
                                                                              image <- img(src = value,
                                                                                           style = df$lg.5.style[index],
                                                                                           alt = value)
                                                                            }
                                                                          },
                                                                          style = function(value, index) {
                                                                            list(background = df$cup.color[index])}
                                            ),
                                            lg.5.style = reactable::colDef(show = FALSE),
                                            excess.ppg = reactable::colDef(name = "Excess PPG",
                                                                           show = input$epl_table_season == current_season_full,
                                                                           style = cs_excess_ppg,
                                                                           width = NULL),
                                            strength = reactable::colDef(name = "Strength",
                                                                         show = input$epl_table_season == current_season_full,
                                                                         format = reactable::colFormat(separators = TRUE),
                                                                         style = cs_strength,
                                                                         width = NULL),
                                            expected.points = reactable::colDef(name = "Expected Points",
                                                                                show = input$epl_table_season == current_season_full,
                                                                                style = cs_expected_points,
                                                                                width = NULL),
                                            strength.upcoming = reactable::colDef(name = "Strength",
                                                                                  show = input$epl_table_season == current_season_full,
                                                                                  format = reactable::colFormat(separators = TRUE),
                                                                                  style = cs_strength_upcoming,
                                                                                  width = NULL)
                             )
        )
    })
    
    # Server: FDB Rankings----
    fdb_rank_reactive <- shiny::reactive({
      req(input$fd_metric)
      req(input$fd_team)
      req(input$fd_dates)
      fdb_ratings_df %>%
        dplyr::filter(team %in% input$fd_team &
                        metric == input$fd_metric &
                        month >= input$fd_dates[1] &
                        month <= input$fd_dates[2])
    })
    
    output$fdb_rank <- plotly::renderPlotly({
      req(input$fd_metric)
      req(input$fd_team)
      df <- fdb_rank_reactive()
      min_month <- min(df$month)
      max_month <- max(df$month)
      month_end <- max_month + ((max_month - min_month) / 3)
      if (max(df$value) <= 100) {
        by_tick <- 10
      } else if (max(df$value) <= 200) {
        by_tick <- 20
      } else {
        by_tick <- 50
      }
      if (min(df$value) < 10) {
        ticks <- c(1, seq(from = 10, to = max(df$value), by = by_tick))
      } else {
        ticks <- seq(from = 10, to = max(df$value), by = by_tick)
      }
      if (input$fd_metric == "Rank") {
        yaxis_list <- list(title = list(text = input$fd_metric,
                                        font = list(color = 'purple', size = 22)),
                           tickformat = ",",
                           zeroline = FALSE,
                           autotick = F,
                           tickmode = "array",
                           tickvals = ticks,
                           autorange = "reversed",
                           tickfont = list(color = 'black', size = 20))
        
      } else {
        yaxis_list <- list(title = list(text = input$fd_metric,
                                        font = list(color = 'purple', size = 22)),
                           tickformat = ",",
                           tickfont = list(color = 'black', size = 20))
      }
      df %>%
        plotly::plot_ly(x = ~month,
                        y = ~value,
                        color = ~team,
                        colors = unique(df$team.color),
                        type = "scatter",
                        mode = 'lines+markers',
                        hoverinfo = 'text',
                        text = paste0(.$team,
                                      "<br>", input$fd_metric,
                                      "<br><br>", format(.$month, '%B %Y'), " | ", 
                                      scales::comma(.$value, acccuracy = 1)
                        )
        ) %>%
        plotly::add_trace(x = ~month, 
                          y = ~value, 
                          type = 'scatter', 
                          mode = 'text', 
                          text = ~text,
                          textposition = 'right', 
                          textfont = list(size = 16), 
                          showlegend = FALSE, 
                          hoverinfo = 'none') %>%
        plotly::layout(showlegend = FALSE,
                       yaxis = yaxis_list,
                       xaxis = list(title = list(text = 'Month',
                                                 font = list(color = 'purple', size = 22)),
                                    tickformat = "%b %Y",
                                    range = c(min_month - 31, month_end),
                                    tickfont = list(color = 'black', size = 20)))
    })
    
    # Server: Fixtures----
    fixture_reactive <- shiny::reactive({
      req(input$fixture_type)
      if (input$fixture_type == 'Upcoming') {
        dplyr::mutate(upcoming_df, Competition = paste0("<img height='30' src='", gsub(" ", "", Competition), "'></img>"))
      } else if (input$fixture_type == 'Finished') {
        dplyr::mutate(finished_df, Competition = paste0("<img height='30' src='", gsub(" ", "", Competition), "'></img>"))
      }
    })
    
    output$fixtures <- DT::renderDataTable({
      DT::datatable(fixture_reactive(),
                    escape = FALSE,
                    options = list(pageLength = 20, 
                                   sort = FALSE),
                    rownames = FALSE)
    })
  }

# Shiny App ----
shiny::shinyApp(ui, server)