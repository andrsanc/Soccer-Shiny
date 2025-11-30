# Prepare data
by_opponent_games_df <-
  by_opponent_raw_df %>%
  dplyr::filter(season == current_season_full) %>%
  dplyr::select(team, opponent, game.number, last.game.ind)

# Points, GF, and GA in last 5 season
by_opponent_pts_df <- 
  last5_season_df %>%
  merge(by_opponent_games_df) %>%
  dplyr::mutate(metric = 'points') %>%
  dplyr::left_join(reshape2::melt(by_opponent_raw_df, id.vars = c('team', 'opponent', 'season'), 
                                  measure.vars = 'points',
                                  variable.name = 'metric'),
                   by = c('team', 'opponent', 'season', 'metric')) %>%
  dplyr::mutate(metric = paste0(metric, ".", season.number)) %>%
  reshape2::dcast(team + opponent + game.number + last.game.ind ~ metric, value.var = 'value')
by_opponent_gf_df <- 
  last5_season_df %>%
  merge(by_opponent_games_df) %>%
  dplyr::mutate(metric = 'goals.scored') %>%
  dplyr::left_join(reshape2::melt(by_opponent_raw_df, id.vars = c('team', 'opponent', 'season'), 
                                  measure.vars = 'goals.scored',
                                  variable.name = 'metric'),
                   by = c('team', 'opponent', 'season', 'metric')) %>%
  dplyr::mutate(metric = paste0(metric, ".", season.number)) %>%
  reshape2::dcast(team + opponent + game.number + last.game.ind ~ metric, value.var = 'value')
by_opponent_ga_df <- 
  last5_season_df %>%
  merge(by_opponent_games_df) %>%
  dplyr::mutate(metric = 'goals.conceded') %>%
  dplyr::left_join(reshape2::melt(by_opponent_raw_df, id.vars = c('team', 'opponent', 'season'), 
                                  measure.vars = 'goals.conceded',
                                  variable.name = 'metric'),
                   by = c('team', 'opponent', 'season', 'metric')) %>%
  dplyr::mutate(metric = paste0(metric, ".", season.number)) %>%
  reshape2::dcast(team + opponent + game.number + last.game.ind ~ metric, value.var = 'value')
by_opponent_pts_gf_ga_df <-
  by_opponent_pts_df %>%
  dplyr::inner_join(by_opponent_gf_df, by = c('team', 'opponent', 'game.number', 'last.game.ind')) %>%
  dplyr::inner_join(by_opponent_ga_df, by = c('team', 'opponent', 'game.number', 'last.game.ind')) %>%
  dplyr::select(team, last.game.ind, game.number, opponent,
                points.1, points.2, points.3, points.4, points.5, 
                goals.scored.1, goals.scored.2, goals.scored.3, goals.scored.4, goals.scored.5, 
                goals.conceded.1, goals.conceded.2, goals.conceded.3, goals.conceded.4, goals.conceded.5)

# Metrics for entire season
by_opponent_all_df <-
  by_opponent_pts_gf_ga_df %>%
  dplyr::select(-last.game.ind, -game.number, -opponent) %>%
  dplyr::group_by(team) %>%
  dplyr::summarise_all(mean, na.rm = TRUE) %>%
  dplyr::mutate(dplyr::across(setdiff(colnames(.), c("team")), \(x) round(x, 2))) %>%
  dplyr::mutate(opponent = "All Opponents",
                game.number = 0,
                last.game.ind = 'Last 5')

# Finalize
by_opponent_df <-
  rbind(by_opponent_pts_gf_ga_df, by_opponent_all_df) %>%
  dplyr::arrange(team, game.number)

rm(last5_season_df, by_opponent_games_df, by_opponent_raw_df, by_opponent_pts_df, by_opponent_gf_df, by_opponent_ga_df, 
   by_opponent_pts_gf_ga_df, by_opponent_all_df)