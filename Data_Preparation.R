# Format dates
upcoming_by_team_raw_df <- dplyr::mutate(upcoming_by_team_raw_df, date = lubridate::ymd(date)) 
simulation_ts_raw_df <- dplyr::mutate(simulation_ts_raw_df, sim.date = lubridate::ymd(sim.date))
fdb_ratings_raw_df <- dplyr::mutate(fdb_ratings_raw_df, Month = lubridate::ymd(Month)) 
upcoming_raw_df <- dplyr::mutate(upcoming_raw_df, date = lubridate::ymd(date), date.local = as.POSIXct(date.local))
finished_raw_df <- dplyr::mutate(finished_raw_df, date = lubridate::ymd(date), date.local = as.POSIXct(date.local))

# Current season
current_season <- dplyr::filter(by_fixture_raw_df, current.season.ind == "Yes")$season[1]
current_season_full <- dplyr::filter(epl_table_raw_df, current.season.ind == "Current")$season[1]

# EPL teams
epl_teams_df <-
  by_fixture_raw_df %>%
  dplyr::filter(current.season.ind == "Yes") %>%
  dplyr::select(team) %>%
  dplyr::distinct()
epl_teams <- epl_teams_df$team

# Last 5 seasons
last5_season_df <-
  epl_table_raw_df %>%
  dplyr::select(season) %>%
  dplyr::distinct() %>%
  dplyr::arrange(desc(season)) %>%
  dplyr::mutate(season.number = dplyr::row_number()) %>%
  dplyr::filter(season.number <= 5)
last5_seasons <- last5_season_df$season

# EPL season end date
epl_season_end <-
  upcoming_raw_df %>%
  dplyr::filter(league.name == "English Premier League") %>%
  dplyr::mutate(date = lubridate::ymd(date)) %>%
  dplyr::summarise(date = max(date)) %>%
  .$date

# EPL season end date
epl_seasons <-
  epl_table_raw_df %>%
  dplyr::select(season) %>%
  dplyr::distinct() %>%
  .$season

# Simulation start date
sim_start_date <- simulation_ts_raw_df %>%
  dplyr::mutate(sim.date = lubridate::ymd(sim.date)) %>%
  dplyr::summarise(sim.date = min(sim.date)) %>%
  .$sim.date

# Number of games in last 5
last5_num_games <- max(last5_raw_df$game.number)

# Updated time stamp
last_updated <- as.POSIXct(last_updated_raw_df$Updated[1])
last_updated_text <- paste0("Updated on ", format(last_updated, "%B %d, %Y"), " at ", format(last_updated, "%I:%M %P"))
rm(last_updated_raw_df)