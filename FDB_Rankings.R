# Prepare data
fdb_ratings_df <- 
  fdb_ratings_raw_df %>%
  dplyr::rename(Rank = Ranking) %>%
  reshape2::melt(id.vars = c('Month', 'Team'), variable.name = 'Metric') %>%
  dplyr::mutate(text = ifelse(Month == max(Month) & !is.na(value), 
                              paste(Team, ": ", scales::comma(value, accuracy = 1)), NA)) %>%
  dplyr::left_join(teams_df, by = c("Team" = "team")) %>%
  dplyr::select(-team.logo, -team.style)
colnames(fdb_ratings_df) <- tolower(colnames(fdb_ratings_df))
rm(fdb_ratings_raw_df)

# Plot axis
fd_plot_min_date <- min(fdb_ratings_df$month)
fd_plot_max_date <- max(fdb_ratings_df$month)

# UI menu
fd_metrics <- c("Points", "Rank")
top4_teams <- unique(c("Liverpool FC", dplyr::filter(epl_table_df, season == current_season_full & position <= 4)$team))
fd_plot_last36 <- c(fd_plot_max_date - months(36), fd_plot_max_date)
