# Prepare data
upcoming_by_team_df <- 
  upcoming_by_team_raw_df %>%
  dplyr::arrange(team, date) %>%
  dplyr::mutate(date.text = format(date, '%A, %B %d %Y'),
                date = format(date, '%Y-%m-%d'),
                team.proj.goals = round(team.proj.goals, 1),
                opponent.proj.goals = round(opponent.proj.goals, 1),
                score = ifelse(is.na(opponent.spi), '',paste0(team.proj.goals, " - ", opponent.proj.goals)),
                bar.color = ifelse(team.spi >= opponent.spi, "#004000", "#800101")) %>%
  dplyr::arrange(team, date) %>%
  dplyr::filter(team %in% epl_teams) %>%
  dplyr::left_join(leagues_df, by = "league.name") %>%
  dplyr::select(team, league.name, league.style, date, league.logo, date.text, opponent, last.result, team.spi, opponent.spi, bar.color, 
                score, win.prob, tie.prob, loss.prob)

rm(upcoming_by_team_raw_df)