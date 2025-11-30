# Team (colors must be unique)
teams_df <- 
  rbind(data.frame(team = "AFC Bournemouth",
                   team.logo = "https://upload.wikimedia.org/wikipedia/en/thumb/e/e5/AFC_Bournemouth_%282013%29.svg/320px-AFC_Bournemouth_%282013%29.svg.png",
                   team.color = "#af1a1f",
                   team.style = "width:35px;height:45px;"),
        
        data.frame(team = "Arsenal FC",
                   team.logo = "https://upload.wikimedia.org/wikipedia/en/thumb/5/53/Arsenal_FC.svg/380px-Arsenal_FC.svg.png",
                   team.color = "#cc000a",
                   team.style = "width:35px;height:40px;"),
        
        data.frame(team = "Aston Villa FC",
                   team.logo = "https://upload.wikimedia.org/wikipedia/en/thumb/9/9a/Aston_Villa_FC_new_crest.svg/320px-Aston_Villa_FC_new_crest.svg.png",
                   team.color = "#9fbbe0",
                   team.style = "width:35px;height:45px;"),
        
        data.frame(team = "Barnsley FC",
                   team.logo = "https://upload.wikimedia.org/wikipedia/en/thumb/c/c9/Barnsley_FC.svg/400px-Barnsley_FC.svg.png",
                   team.color = "#8c1016",
                   team.style = "width:40px;height:40px;"),
        
        data.frame(team = "Birmingham City FC",
                   team.logo = "https://upload.wikimedia.org/wikipedia/en/thumb/6/68/Birmingham_City_FC_logo.svg/320px-Birmingham_City_FC_logo.svg.png",
                   team.color = "#2d3f8c",
                   team.style = "width:40px;height:40px;"),
        
        data.frame(team = "Blackburn Rovers FC",
                   team.logo = "https://upload.wikimedia.org/wikipedia/en/thumb/0/0f/Blackburn_Rovers.svg/380px-Blackburn_Rovers.svg.png",
                   team.color = "#599ddc",
                   team.style = "width:40px;height:40px;"),
        
        data.frame(team = "Blackpool FC",
                   team.logo = "https://upload.wikimedia.org/wikipedia/en/thumb/d/df/Blackpool_FC_logo.svg/400px-Blackpool_FC_logo.svg.png",
                   team.color = "#d88226",
                   team.style = "width:40px;height:40px;"),
        
        data.frame(team = "Bolton Wanderers FC",
                   team.logo = "https://upload.wikimedia.org/wikipedia/en/thumb/8/82/Bolton_Wanderers_FC_logo.svg/380px-Bolton_Wanderers_FC_logo.svg.png",
                   team.color = "#313e7c",
                   team.style = "width:40px;height:40px;"),
        
        data.frame(team = "Bradford City AFC",
                   team.logo = "https://upload.wikimedia.org/wikipedia/en/thumb/0/04/Bradford_City_AFC_crest.svg/320px-Bradford_City_AFC_crest.svg.png",
                   team.color = "#e6ae36",
                   team.style = "width:40px;height:40px;"),
        
        data.frame(team = "Brentford FC",
                   team.logo = "https://upload.wikimedia.org/wikipedia/en/thumb/2/2a/Brentford_FC_crest.svg/400px-Brentford_FC_crest.svg.png",
                   team.color = "#a50000",
                   team.style = "width:40px;height:40px;"),
        
        data.frame(team = "Brighton & Hove Albion FC",
                   team.logo = "https://upload.wikimedia.org/wikipedia/en/thumb/d/d0/Brighton_and_Hove_Albion_FC_crest.svg/420px-Brighton_and_Hove_Albion_FC_crest.svg.png",
                   team.color = "#355ca5",
                   team.style = "width:40px;height:40px;"),
        
        data.frame(team = "Burnley FC",
                   team.logo = "https://upload.wikimedia.org/wikipedia/en/thumb/6/6d/Burnley_FC_Logo.svg/400px-Burnley_FC_Logo.svg.png",
                   team.color = "#510042",
                   team.style = "width:35px;height:40px;"),
        
        data.frame(team = "Cardiff City FC",
                   team.logo = "https://upload.wikimedia.org/wikipedia/en/thumb/3/3c/Cardiff_City_crest.svg/400px-Cardiff_City_crest.svg.png",
                   team.color = "#3e59aa",
                   team.style = "width:40px;height:40px;"),
        
        data.frame(team = "Charlton Athletic FC",
                   team.logo = "https://upload.wikimedia.org/wikipedia/en/thumb/f/f5/Charlton_Athletic_FC_crest.svg/400px-Charlton_Athletic_FC_crest.svg.png",
                   team.color = "#b92d2d",
                   team.style = "width:40px;height:40px;"),
        
        data.frame(team = "Chelsea FC",
                   team.logo = "https://upload.wikimedia.org/wikipedia/en/thumb/c/cc/Chelsea_FC.svg/430px-Chelsea_FC.svg.png",
                   team.color = "#071a84",
                   team.style = "width:40px;height:40px;"),
        
        data.frame(team = "Coventry City FC",
                   team.logo = "https://upload.wikimedia.org/wikipedia/en/thumb/7/7b/Coventry_City_FC_crest.svg/290px-Coventry_City_FC_crest.svg.png",
                   team.color = "#599dd8",
                   team.style = "width:35px;height:40px;"),
        
        data.frame(team = "Crystal Palace FC",
                   team.logo = "https://upload.wikimedia.org/wikipedia/en/thumb/a/a2/Crystal_Palace_FC_logo_%282022%29.svg/370px-Crystal_Palace_FC_logo_%282022%29.svg.png",
                   team.color = "#3055a0",
                   team.style = "width:40px;height:40px;"),
        
        data.frame(team = "Derby County FC",
                   team.logo = "https://upload.wikimedia.org/wikipedia/en/thumb/4/4a/Derby_County_crest.svg/460px-Derby_County_crest.svg.png",
                   team.color = "#000001",
                   team.style = "width:40px;height:40px;"),
        
        data.frame(team = "Everton FC",
                   team.logo = "https://upload.wikimedia.org/wikipedia/en/thumb/7/7c/Everton_FC_logo.svg/420px-Everton_FC_logo.svg.png",
                   team.color = "#000099",
                   team.style = "width:40px;height:40px;"),
        
        data.frame(team = "Fulham FC",
                   team.logo = "https://upload.wikimedia.org/wikipedia/en/thumb/e/eb/Fulham_FC_%28shield%29.svg/320px-Fulham_FC_%28shield%29.svg.png",
                   team.color = "#000000",
                   team.style = "width:40px;height:45px;"),
        
        data.frame(team = "Huddersfield Town AFC",
                   team.logo = "https://upload.wikimedia.org/wikipedia/en/thumb/4/43/Huddersfield_Town_AFC_crest.svg/300px-Huddersfield_Town_AFC_crest.svg.png",
                   team.color = "#477ef4",
                   team.style = "width:30px;height:40px;"),
        
        data.frame(team = "Hull City AFC",
                   team.logo = "https://upload.wikimedia.org/wikipedia/en/thumb/5/54/Hull_City_A.F.C._logo.svg/340px-Hull_City_A.F.C._logo.svg.png",
                   team.color = "#d98920",
                   team.style = "width:40px;height:40px;"),
        
        data.frame(team = "Ipswich Town FC",
                   team.logo = "https://upload.wikimedia.org/wikipedia/en/thumb/4/43/Ipswich_Town.svg/340px-Ipswich_Town.svg.png",
                   team.color = "#4b649f",
                   team.style = "width:35px;height:40px;"),
        
        data.frame(team = "Leeds United AFC",
                   team.logo = "https://upload.wikimedia.org/wikipedia/en/thumb/5/54/Leeds_United_F.C._logo.svg/340px-Leeds_United_F.C._logo.svg.png",
                   team.color = "#f4db3a",
                   team.style = "width:35px;height:45px;"),
        
        data.frame(team = "Leicester City FC",
                   team.logo = "https://upload.wikimedia.org/wikipedia/en/thumb/2/2d/Leicester_City_crest.svg/400px-Leicester_City_crest.svg.png",
                   team.color = "#ecbc31",
                   team.style = "width:40px;height:40px;"),
        
        data.frame(team = "Liverpool FC",
                   team.logo = "https://upload.wikimedia.org/wikipedia/en/thumb/0/0c/Liverpool_FC.svg/400px-Liverpool_FC.svg.png",
                   team.color = "#bf0101",
                   team.style = "width:45px;height:55px;"),
        
        data.frame(team = "Luton Town FC",
                   team.logo = "https://upload.wikimedia.org/wikipedia/en/thumb/9/9d/Luton_Town_logo.svg/400px-Luton_Town_logo.svg.png",
                   team.color = "#dd430a",
                   team.style = "width:40px;height:40px;"),
        
        data.frame(team = "Manchester City FC",
                   team.logo = "https://upload.wikimedia.org/wikipedia/en/thumb/e/eb/Manchester_City_FC_badge.svg/420px-Manchester_City_FC_badge.svg.png",
                   team.color = "#93bcea",
                   team.style = "width:40px;height:40px;"),
        
        data.frame(team = "Manchester United FC",
                   team.logo = "https://upload.wikimedia.org/wikipedia/en/thumb/7/7a/Manchester_United_FC_crest.svg/440px-Manchester_United_FC_crest.svg.png",
                   team.color = "#f4de35",
                   team.style = "width:40px;height:40px;"),
        
        data.frame(team = "Middlesbrough FC",
                   team.logo = "https://upload.wikimedia.org/wikipedia/en/thumb/2/2c/Middlesbrough_FC_crest.svg/400px-Middlesbrough_FC_crest.svg.png",
                   team.color = "#db0001",
                   team.style = "width:40px;height:40px;"),
        
        data.frame(team = "Newcastle United FC",
                   team.logo = "https://upload.wikimedia.org/wikipedia/en/thumb/5/56/Newcastle_United_Logo.svg/430px-Newcastle_United_Logo.svg.png",
                   team.color = "#030303",
                   team.style = "width:40px;height:40px;"),
        
        data.frame(team = "Norwich City FC",
                   team.logo = "https://upload.wikimedia.org/wikipedia/en/thumb/1/17/Norwich_City_FC_logo.svg/340px-Norwich_City_FC_logo.svg.png",
                   team.color = "#4f8b46",
                   team.style = "width:35px;height:40px;"),
        
        data.frame(team = "Nottingham Forest FC",
                   team.logo = "https://upload.wikimedia.org/wikipedia/en/thumb/e/e5/Nottingham_Forest_F.C._logo.svg/240px-Nottingham_Forest_F.C._logo.svg.png",
                   team.color = "#bc0000",
                   team.style = "width:30px;height:50px;"),
        
        data.frame(team = "Oldham Athletic AFC",
                   team.logo = "https://upload.wikimedia.org/wikipedia/en/thumb/a/a2/Oldham_Athletic_AFC_%28emblem%29.svg/220px-Oldham_Athletic_AFC_%28emblem%29.svg.png",
                   team.color = "#2846fa",
                   team.style = "width:30px;height:40px;"),
        
        data.frame(team = "Portsmouth FC",
                   team.logo = "https://upload.wikimedia.org/wikipedia/en/thumb/3/38/Portsmouth_FC_logo.svg/420px-Portsmouth_FC_logo.svg.png",
                   team.color = "#344097",
                   team.style = "width:40px;height:40px;"),
        
        data.frame(team = "Queens Park Rangers FC",
                   team.logo = "https://upload.wikimedia.org/wikipedia/en/thumb/3/31/Queens_Park_Rangers_crest.svg/410px-Queens_Park_Rangers_crest.svg.png",
                   team.color = "#0000e1",
                   team.style = "width:40px;height:40px;"),
        
        data.frame(team = "Reading FC",
                   team.logo = "https://upload.wikimedia.org/wikipedia/en/thumb/1/11/Reading_FC.svg/400px-Reading_FC.svg.png",
                   team.color = "#bd1d41",
                   team.style = "width:40px;height:40px;"),
        
        data.frame(team = "Sheffield United FC",
                   team.logo = "https://upload.wikimedia.org/wikipedia/en/thumb/9/9c/Sheffield_United_FC_logo.svg/400px-Sheffield_United_FC_logo.svg.png",
                   team.color = "#cb272c",
                   team.style = "width:40px;height:40px;"),
        
        data.frame(team = "Sheffield Wednesday FC",
                   team.logo = "https://upload.wikimedia.org/wikipedia/en/thumb/8/88/Sheffield_Wednesday_badge.svg/280px-Sheffield_Wednesday_badge.svg.png",
                   team.color = "#5c80cb",
                   team.style = "width:35px;height:40px;"),
        
        data.frame(team = "Southampton FC",
                   team.logo = "https://upload.wikimedia.org/wikipedia/en/thumb/c/c9/FC_Southampton.svg/400px-FC_Southampton.svg.png",
                   team.color = "#cb203c",
                   team.style = "width:40px;height:40px;"),
        
        data.frame(team = "Stoke City FC",
                   team.logo = "https://upload.wikimedia.org/wikipedia/en/thumb/5/5e/Stoke_City_FC_crest_2001.svg/350px-Stoke_City_FC_crest_2001.svg.png",
                   team.color = "#b11a31",
                   team.style = "width:40px;height:40px;"),
        
        data.frame(team = "Sunderland AFC",
                   team.logo = "https://upload.wikimedia.org/wikipedia/en/thumb/7/77/Logo_Sunderland.svg/520px-Logo_Sunderland.svg.png",
                   team.color = "#db0000",
                   team.style = "width:40px;height:40px;"),
        
        data.frame(team = "Swansea City AFC",
                   team.logo = "https://upload.wikimedia.org/wikipedia/en/thumb/f/f9/Swansea_City_AFC_logo.svg/420px-Swansea_City_AFC_logo.svg.png",
                   team.color = "#000002",
                   team.style = "width:40px;height:40px;"),
        
        data.frame(team = "Swindon Town FC",
                   team.logo = "https://upload.wikimedia.org/wikipedia/en/thumb/a/a3/Swindon_Town_FC.svg/400px-Swindon_Town_FC.svg.png",
                   team.color = "#bd1d21",
                   team.style = "width:40px;height:40px;"),
        
        data.frame(team = "Tottenham Hotspur FC",
                   team.logo = "https://upload.wikimedia.org/wikipedia/en/thumb/b/b4/Tottenham_Hotspur.svg/260px-Tottenham_Hotspur.svg.png",
                   team.color = "#1e2756",
                   team.style = "width:30px;height:45px;"),
        
        data.frame(team = "Watford FC",
                   team.logo = "https://upload.wikimedia.org/wikipedia/en/thumb/e/e2/Watford.svg/380px-Watford.svg.png",
                   team.color = "#f7ed21",
                   team.style = "width:40px;height:40px;"),
        
        data.frame(team = "West Bromwich Albion FC",
                   team.logo = "https://upload.wikimedia.org/wikipedia/en/thumb/8/8b/West_Bromwich_Albion.svg/340px-West_Bromwich_Albion.svg.png",
                   team.color = "#101b53",
                   team.style = "width:35px;height:40px;"),
        
        data.frame(team = "West Ham United FC",
                   team.logo = "https://upload.wikimedia.org/wikipedia/en/thumb/c/c2/West_Ham_United_FC_logo.svg/370px-West_Ham_United_FC_logo.svg.png",
                   team.color = "#6b2f3c",
                   team.style = "width:40px;height:45px;"),
        
        data.frame(team = "Wigan Athletic AFC",
                   team.logo = "https://upload.wikimedia.org/wikipedia/en/thumb/4/43/Wigan_Athletic.svg/400px-Wigan_Athletic.svg.png",
                   team.color = "#395aab",
                   team.style = "width:40px;height:40px;"),
        
        data.frame(team = "Wimbledon FC",
                   team.logo = "https://upload.wikimedia.org/wikipedia/en/thumb/b/b3/Wimbledon_FC_crest.svg/300px-Wimbledon_FC_crest.svg.png",
                   team.color = "#0000fb",
                   team.style = "width:40px;height:40px;"),
        
        data.frame(team = "Wolverhampton Wanderers FC",
                   team.logo = "https://upload.wikimedia.org/wikipedia/en/thumb/c/c9/Wolverhampton_Wanderers_FC_crest.svg/420px-Wolverhampton_Wanderers_FC_crest.svg.png",
                   team.color = "#edb831",
                   team.style = "width:45px;height:40px;")
  )

if (nrow(teams_df) != length(unique(teams_df$team.color))) {
  print("Team colors must be unique")
  print(teams_df %>%
          dplyr::group_by(team.color) %>%
          dplyr::filter(n() > 1) %>%
          dplyr::select(team, team.color))
  rm(teams_df)
}

# Domestic Leagues and European Cups
leagues_df <- 
  rbind(data.frame(league.name = "English Premier League",
                   league.logo = "https://upload.wikimedia.org/wikipedia/en/thumb/f/f2/Premier_League_Logo.svg/500px-Premier_League_Logo.svg.png",
                   league.color = "white",
                   league.style = "width:52px;height:25px;"),
        
        data.frame(league.name = "FA Cup",
                   league.logo = "https://upload.wikimedia.org/wikipedia/en/5/55/FA_Cup_2020.png",
                   
                   league.color = "white",
                   league.style = "width:40px;height:40px;"),
        
        data.frame(league.name = "EFL Cup",
                   league.logo = "https://upload.wikimedia.org/wikipedia/en/thumb/0/0c/EFL_%28Carabao%29_Cup_Logo.svg/300px-EFL_%28Carabao%29_Cup_Logo.svg.png",
                   league.color = "white",
                   league.style = "width:30px;height:40px;"),
        
        data.frame(league.name = "FA Community Shield",
                   league.logo = "https://upload.wikimedia.org/wikipedia/en/d/da/FA_Community_Shield_logo.png",
                   league.color = "white",
                   league.style = "width:40px;height:40px;"),
        
        data.frame(league.name = "FIFA Club World Cup",
                   league.logo = "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4e/FIFA_Club_World_Cup_logo.svg/400px-FIFA_Club_World_Cup_logo.svg.png",
                   league.color = "white",
                   league.style = "width:40px;height:40px;"),
        
        data.frame(league.name = "FIFA Intercontinental Cup",
                   league.logo = "https://upload.wikimedia.org/wikipedia/en/2/27/FIFA_Intercontinental_Cup.png",
                   league.color = "white",
                   league.style = "width:40px;height:40px;"),
        
        data.frame(league.name = "UEFA Super Cup",
                   league.logo = "https://upload.wikimedia.org/wikipedia/en/thumb/0/0b/UEFA_Super_Cup_logo.svg/380px-UEFA_Super_Cup_logo.svg.png",
                   league.color = "white",
                   league.style = "width:35px;height:40px;"),
        
        data.frame(league.name = "Football League First Division",
                   league.logo = "https://upload.wikimedia.org/wikipedia/en/thumb/c/cb/English_Football_League_Logo.svg/300px-English_Football_League_Logo.svg.png",
                   league.color = "#ffffb2",
                   league.style = "width:30px;height:40px;"),
        
        data.frame(league.name = "Football League Championship",
                   league.logo = "https://upload.wikimedia.org/wikipedia/en/thumb/0/0f/EFL_Championship_Logo.svg/330px-EFL_Championship_Logo.svg.png",
                   league.color = "#ffffb2",
                   league.style = "width:30px;height:40px;"),
        
        data.frame(league.name = "EFL Championship",
                   league.logo = "https://upload.wikimedia.org/wikipedia/en/thumb/0/0f/EFL_Championship_Logo.svg/330px-EFL_Championship_Logo.svg.png",
                   league.color = "#ffffb2",
                   league.style = "width:30px;height:40px;"),
        
        data.frame(league.name = "UEFA Champions League",
                   league.logo = "https://upload.wikimedia.org/wikipedia/en/thumb/f/f5/UEFA_Champions_League.svg/500px-UEFA_Champions_League.svg.png",
                   league.color = "#cccccc",
                   league.style = "width:38px;height:40px;"),
        
        data.frame(league.name = "UEFA Europa League",
                   #league.logo = "https://upload.wikimedia.org/wikipedia/en/7/73/UEFA_Europa_League_2024.png",
                   league.logo = "https://upload.wikimedia.org/wikipedia/commons/thumb/1/1b/UEFA_Europa_League_logo_%282024_version%29.svg/960px-UEFA_Europa_League_logo_%282024_version%29.svg.png?20240926025310",
                   league.color = "#ffdb99",
                   league.style = "width:30px;height:40px;"),
        
        data.frame(league.name = "UEFA Conference League",
                   league.logo = "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4b/UEFA_Conference_League_full_logo_%282024_version%29.svg/500px-UEFA_Conference_League_full_logo_%282024_version%29.svg.png",
                   league.color = "#b2d8b2",
                   league.style = "width:40px;height:40px;"),
        
        data.frame(league.name = "UEFA Cup",
                   league.logo = "https://upload.wikimedia.org/wikipedia/en/7/73/UEFA_Europa_League_2024.png",
                   league.color = "#ffdb99",
                   league.style = "width:30px;height:40px;"),
        
        data.frame(league.name = "UEFA Cup Winners Cup",
                   league.logo = "https://upload.wikimedia.org/wikipedia/en/f/f2/Cup_Winners_Cup.png",
                   league.color = "#99cccc",
                   league.style = "width:45px;height:40px;"),
        
        data.frame(league.name = "UEFA Intertoto Cup",
                   league.logo = "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6e/UEFA_Intertoto_Cup.svg/400px-UEFA_Intertoto_Cup.svg.png",
                   league.color = "#b2d8b2",
                   league.style = "width:40px;height:40px;"))

# Last 5 Results: https://icon-icons.com
# "https://cdn3.iconfinder.com/data/icons/softwaredemo/PNG/256x256/Circle_Green.png"
# "https://cdn3.iconfinder.com/data/icons/softwaredemo/PNG/256x256/Circle_Grey.png"
# "https://cdn3.iconfinder.com/data/icons/softwaredemo/PNG/256x256/Circle_Red.png"

l5_results_df <- 
  rbind(data.frame(l5.result = "Win",
                   l5.logo = "https://www.premierleague.com/resources/v1.29.18/i/svg-files/elements/form-win.svg",
                   l5.style = "width:28px;height:28px;"),
        
        data.frame(l5.result = "Draw",
                   l5.logo = "https://www.premierleague.com/resources/v1.29.18/i/svg-files/elements/form-draw.svg",
                   l5.style = "width:28px;height:28px;"), 
        
        data.frame(l5.result = "Loss",
                   l5.logo = "https://www.premierleague.com/resources/v1.29.18/i/svg-files/elements/form-loss.svg",
                   l5.style = "width:28px;height:28px;"))
#last5_logos_df <- dplyr::mutate(last5_logos_df, result = paste0("<img height='30' src='", gsub(" ", "", result), "'></img>"))