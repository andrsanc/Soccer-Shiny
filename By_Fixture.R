# UI menus
by_fixture_comp <- c("EPL Champions", 
                     "Teams Qualified to Champions", 
                     "Teams Qualified to Europa League", 
                     "Teams Relegated", 
                     "Last 5 Seasons")  
by_fixture_metric <- c("Points", "Goals Scored", "Goals Conceded", "Wins Away")

# Against metric name
by_fixture_against_df <-
  data.frame(metric = c("winner.ind", "ucl.ind", "europa.ind", "relegated.ind", "last.5"),
             against = by_fixture_comp)

# Against cohorts
against_cohorts_df <-
  by_fixture_raw_df %>%
  dplyr::filter(current.season.ind == "No") %>%
  dplyr::select(metric.name, fixture, winner.ind, metric.running, ucl.ind, europa.ind, relegated.ind) %>%
  reshape2::melt(id.vars = c("metric.name", "fixture", "metric.running"),
                 variable.name = 'metric') %>%
  dplyr::filter(value == 'Yes') %>%
  dplyr::inner_join(by_fixture_against_df, by = "metric") %>%
  dplyr::mutate(team = "Any team") %>%
  dplyr::group_by(team, metric.name, against, fixture) %>%
  dplyr::summarise(min = min(metric.running),
                   max = max(metric.running),
                   avg = round(mean(metric.running), 1),
                   .groups = 'drop')

# Against last 5 seasons
against_last5_df <-
  by_fixture_raw_df %>%
  dplyr::filter(current.season.ind == "No" &
                  season >= max(season) - 5) %>%
  dplyr::mutate(metric = "last.5") %>%
  dplyr::inner_join(by_fixture_against_df, by = "metric") %>%
  dplyr::group_by(team, metric.name, against, fixture) %>%
  dplyr::summarise(min = min(metric.running),
                   max = max(metric.running),
                   avg = round(mean(metric.running), 1),
                   .groups = 'drop')

# Combine against cohorts and last 5 seasons
against_all_cohorts_df <-
  rbind(against_cohorts_df, against_last5_df)
rm(against_cohorts_df, against_last5_df)

# Against current season
against_current_df <-
  by_fixture_raw_df %>%
  dplyr::filter(current.season.ind == "Yes") %>%
  dplyr::select(team, metric.name, fixture, metric.running)