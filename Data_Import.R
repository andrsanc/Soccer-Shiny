# Load data 
upcoming_by_team_raw_df <- read.csv("upcoming_games.csv")
by_fixture_raw_df <- read.csv("epl_by_fixture.csv")
upcoming_raw_df <- read.csv("upcoming_fixtures.csv")
finished_raw_df <- read.csv("finished_fixtures.csv")
epl_table_raw_df <- read.csv("epl_table.csv")
last5_raw_df <- read.csv("epl_last_5_games.csv")
by_opponent_raw_df <- read.csv("epl_by_opponent.csv")
simulation_ts_raw_df <- read.csv("epl_simulation_timeline.csv")
sim_standings_raw_df <- read.csv("epl_simulation_positions.csv")
sim_table_raw_df <- read.csv("epl_simulation_results.csv")
fdb_ratings_raw_df <- read.csv("fdb_ratings.csv")
last_updated_raw_df <- read.csv("last_updated.csv")

# Definitions
l5_results_df <- read.csv("last5_results.csv")
leagues_df <- read.csv("leagues.csv")
teams_df <- read.csv("teams.csv")
if (nrow(teams_df) != length(unique(teams_df$team.color))) {
  print("Team colors must be unique")
  print(teams_df %>%
          dplyr::group_by(team.color) %>%
          dplyr::filter(n() > 1) %>%
          dplyr::select(team, team.color))
  rm(teams_df)
}



