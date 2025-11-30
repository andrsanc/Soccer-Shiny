# Histogram
sim_table_hist_df <- data.frame()
for (t in epl_teams) {
  df <- 
    sim_standings_raw_df %>%
    dplyr::filter(last.sim.ind == 1) %>%
    reshape2::dcast(team ~ position, value.var = 'probability') %>%
    replace(is.na(.), 0) %>%
    reshape2::melt(id.vars = c("team")) %>%
    dplyr::filter(team == t) %>%
    dplyr::arrange(team, variable) %>%
    dplyr::mutate(variable = as.numeric(variable)) 
  hist_loess <- stats::loess(value ~ variable, df)
  df$hist <- stats::predict(hist_loess)
  df$hist <- ifelse(df$hist < 0, 0, df$hist)
  df$hist <- df$hist / sum(df$hist)
  sim_table_hist_df <- rbind(df, sim_table_hist_df)
}
rm(t, df)

# Sparkline
sim_table_sparkline_df <-
  sim_table_hist_df %>%
  dplyr::group_by(team) %>%
  dplyr::summarise(pos.hist = list(hist)) %>%
  dplyr::mutate(sparkline = NA)

# Current EPL table
epl_table_current_df <-
  epl_table_raw_df %>%
  dplyr::filter(current.season.ind == 'Current') %>%
  dplyr::rename(games.played = games) %>%
  dplyr::select(season, team, games.played)

# European Qualification
europe_qual_df <-
  epl_table_raw_df %>%
  dplyr::filter(current.season.ind == 'Current') %>%
  dplyr::select(position, europe.qualification, rel.to) %>%
  dplyr::left_join(leagues_df, by = c("europe.qualification" = "league.name")) %>%
  dplyr::left_join(leagues_df, by = c("rel.to" = "league.name")) %>%
  dplyr::mutate(rel.ind = ifelse(rel.to == "No", FALSE, TRUE),
                cup.logo = dplyr::coalesce(league.logo.x, league.logo.y),
                cup.style = dplyr::coalesce(league.style.x, league.style.y),
                cup.color = dplyr::coalesce(league.color.x, league.color.y, "white")) %>%
  dplyr::select(position, cup.logo, cup.style, cup.color, rel.ind) 

# Prepare data
sim_table_df <-
  sim_table_raw_df %>%
  dplyr::filter(last.sim.ind == 1) %>%
  dplyr::left_join(teams_df, by = "team") %>%
  dplyr::left_join(sim_table_sparkline_df, by = "team") %>%
  dplyr::rename(games.total = games) %>%
  dplyr::mutate(season = current_season_full) %>%
  dplyr::left_join(epl_table_current_df, by = c('season', 'team')) %>%
  dplyr::left_join(europe_qual_df, by = c('position')) %>%
  dplyr::mutate(games.sim = games.total - games.played,
                wins = round(wins, 1),
                draws = round(draws, 1),
                losses = round(losses, 1),
                gf = round(gf, 1),
                ga = round(ga, 1),
                gd = round(gd, 1),
                points = round(points, 1),
                winner = ifelse(winner == 0, NA, winner),
                ucl = ifelse(ucl == 0, NA, ucl),
                relegated = ifelse(relegated == 0, NA, relegated),
                team = ifelse(rel.ind, paste0(team, " (R)"),
                              ifelse(position == 1, paste0(team, " (C)"), team))) %>%
  dplyr::select(rel.ind, cup.color, position, team.logo, team.style, team, cup.logo, cup.style, games.played, games.sim, 
                wins, draws, losses, gf, ga, gd, points, winner, ucl, relegated, pos.hist, sparkline) 

rm(sim_standings_raw_df, sim_table_raw_df, sim_table_hist_df, sim_table_sparkline_df, epl_table_current_df, europe_qual_df)
