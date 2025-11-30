# Sim types
sim_type_df <- 
  data.frame(sim = c('winner',
                     'ucl',
                     'europa', 'relegated'),
             sim.type = c('EPL Champion',
                          'Champions League Qualification',
                          'Europa League Qualification',
                          'EPL Relegation'))

# Prepare data: Probability
simulation_ts_prob_df <- 
  simulation_ts_raw_df %>%
  dplyr::mutate(sim.metric = 'Probability',
                y = ifelse(probability < 0.02, NA, probability),
                text = ifelse(sim.date == max(sim.date) & !is.na(probability), 
                              paste(team, ": ", scales::percent(probability, accuracy = 1)), NA)) %>%
  dplyr::filter(probability >= 0.03) %>%
  dplyr::arrange(team, sim, sim.date) %>%
  dplyr::left_join(teams_df, by = c("team")) %>%
  dplyr::inner_join(sim_type_df, by = c("sim"))  %>%
  dplyr::select(sim.date, team, team.color, sim.metric, sim.type, y, text)

# Prepare data: Expected Points
simulation_ts_xp_df <-
  sim_table_raw_df %>%
  dplyr::group_by(sim.date, team) %>%
  dplyr::summarise(y = mean(points), .groups = 'drop') %>%
  dplyr::left_join(teams_df, by = c("team")) %>%
  dplyr::mutate(sim.date = lubridate::ymd(sim.date),
                sim.metric = 'Expected Points',
                sim.type = 'EPL Champion, Champions League Qualification, Europa League Qualification, EPL Relegation',
                text = ifelse(sim.date == max(sim.date), 
                              paste(team, ": ", scales::comma(y, accuracy = .1)), NA)) %>%
  dplyr::select(sim.date, team, team.color, sim.metric, sim.type, y, text)

# Prepare data: Simulation
simulation_ts_df <- rbind(simulation_ts_prob_df, simulation_ts_xp_df) 

# UI menus
sims <- c("EPL Champion", "Champions League Qualification", "Europa League Qualification", "EPL Relegation")
sim_teams_winner <- 
  unique(dplyr::filter(simulation_ts_prob_df, 
                       sim.type == "EPL Champion" & 
                         sim.date == max(sim.date))$team)
sim_teams_ucl <- 
  unique(dplyr::filter(simulation_ts_prob_df, 
                       sim.type == "Champions League Qualification" & 
                         sim.date == max(sim.date))$team)
sim_teams_europa <- 
  unique(dplyr::filter(simulation_ts_prob_df, 
                       sim.type == "Europa League Qualification" & 
                         sim.date == max(sim.date))$team)
sim_teams_rel <- 
  unique(dplyr::filter(simulation_ts_prob_df, 
                       sim.type == "EPL Relegation" & 
                         sim.date == max(sim.date))$team)
sim_metrics <- c("Probability", "Expected Points")

rm(simulation_ts_raw_df, sim_type_df, simulation_ts_prob_df, simulation_ts_xp_df)
