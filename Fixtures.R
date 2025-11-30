# Upcoming fixtures
upcoming_df <- 
  upcoming_raw_df %>%
  dplyr::arrange(date, date.local, home.team) %>%
  dplyr::mutate(date = format(date.local, format = "%A, %B %d %Y"),
                time = format(date.local, format = "%H:%M"),
                time = format(strptime(time, format='%H:%M'), '%I:%M %p')) %>%
  dplyr::left_join(leagues_df, by = "league.name") %>%
  dplyr::select(league.logo, date, time, home.team, away.team) %>%
  dplyr::rename(competition = league.logo)
colnames(upcoming_df) <- gsub(".", " ", colnames(upcoming_df), fixed = TRUE)
colnames(upcoming_df) <- stringr::str_to_title(colnames(upcoming_df))
rm(upcoming_raw_df)

# Finished fixtures
finished_df <- 
  finished_raw_df %>%
  dplyr::mutate(time = format(date.local, format = "%H:%M"),
                time = format(strptime(time, format='%H:%M'), '%I:%M %p'),
                score = paste0(home.goals, " - ", away.goals)) %>%
  dplyr::arrange(desc(date), desc(date.local), home.team) %>%
  dplyr::left_join(leagues_df, by = "league.name") %>%
  dplyr::select(league.logo, date, time, home.team, away.team, score) %>%
  dplyr::rename(competition = league.logo)
colnames(finished_df) <- gsub(".", " ", colnames(finished_df), fixed = TRUE)
colnames(finished_df) <- stringr::str_to_title(colnames(finished_df))
rm(finished_raw_df)

# UI Menu
fixture_types <- c("Finished", "Upcoming")
