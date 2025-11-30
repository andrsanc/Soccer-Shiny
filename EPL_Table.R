# Results for last 5 games
epl_table_last5_df <-
  data.frame(season = current_season_full,
             team = epl_teams) %>%
  merge(data.frame(game.number = seq(5))) %>%
  dplyr::left_join(last5_raw_df[c('team', 'game.number', 'result.description')], 
                   by = c('team', 'game.number')) %>%
  dplyr::mutate(result.description = gsub("at home", "", result.description),
                result.description = gsub("on the road", "", result.description),
                result.description = trimws(result.description),
                game.number = paste0("lg.", game.number)) %>%
  dplyr::left_join(l5_results_df, by = c("result.description" = "l5.result"))

epl_table_last5_logo_df <-
  epl_table_last5_df %>%
  dplyr::mutate(game.number = paste0(game.number, ".logo")) %>%
  reshape2::dcast(season + team ~ game.number, value.var = 'l5.logo')

epl_table_last5_style_df <-
  epl_table_last5_df %>%
  dplyr::mutate(game.number = paste0(game.number, ".style")) %>%
  reshape2::dcast(season + team ~ game.number, value.var = 'l5.style')

last5_num_games <- max(last5_raw_df$game.number)

# Average PPG and Ranking in last 5 games
epl_table_ppg_rank_df <- 
  last5_raw_df %>%
  dplyr::mutate(season = current_season_full,
                excess.ppg = points - xg.points) %>%
  dplyr::group_by(season, team) %>%
  dplyr::summarise(excess.ppg = round(mean(excess.ppg), 1),
                   strength = round(mean(opponent.spi), 0),
                   .groups = 'drop')

# Expected PPG and Ranking for next 5 games
epl_table_next5_df <-
  upcoming_by_team_df %>%
  dplyr::filter(league.name == 'English Premier League') %>%
  dplyr::mutate(season = current_season_full,
                expected.points = win.prob * 3 + tie.prob) %>%
  dplyr::arrange(season, team, date) %>%
  dplyr::group_by(season, team) %>%
  dplyr::filter(dplyr::row_number() <= 5) %>%
  dplyr::summarise(expected.points = round(mean(expected.points), 1),
                   strength.upcoming = round(mean(opponent.spi), 0),
                   .groups = 'drop')

# Finalize
epl_table_df <-
  epl_table_raw_df %>%
  dplyr::left_join(teams_df, by = "team") %>%
  dplyr::left_join(leagues_df, by = c("europe.qualification" = "league.name")) %>%
  dplyr::left_join(leagues_df, by = c("rel.to" = "league.name")) %>%
  dplyr::mutate(rel.ind = ifelse(rel.to == "No", FALSE, TRUE),
                cup.logo = dplyr::coalesce(league.logo.x, league.logo.y),
                cup.style = dplyr::coalesce(league.style.x, league.style.y),
                cup.color = dplyr::coalesce(league.color.x, league.color.y, "white"),
                team = ifelse(season == current_season_full, team,
                              ifelse(rel.ind, paste0(team, " (R)"),
                                     ifelse(position == 1, paste0(team, " (C)"), team)))) %>%
  dplyr::select(season, cup.color, position, team.logo, team.style, team, cup.logo, cup.style,
                games, wins, draws, losses, gf, ga, gd, points) %>%
  dplyr::left_join(epl_table_last5_logo_df, by = c("season", "team")) %>%
  dplyr::left_join(epl_table_last5_style_df, by = c("season", "team")) %>%
  dplyr::left_join(epl_table_ppg_rank_df, by = c("season", "team")) %>%
  dplyr::left_join(epl_table_next5_df, by = c("season", "team")) 

rm(epl_table_raw_df, epl_table_last5_df, epl_table_last5_logo_df, epl_table_last5_style_df, epl_table_ppg_rank_df, epl_table_next5_df)
