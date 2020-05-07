# Write your code below game_hash
def game_hash
  {
    home: {
      team_name: "Brooklyn Nets",
      colors: ["Black", "White"],
      players: [
        {
          player_name: "Alan Anderson",
          number: 0,
          shoe: 16,
          points: 22,
          rebounds: 12,
          assists: 12,
          steals: 3,
          blocks: 1,
          slam_dunks: 1
        },
        {
          player_name: "Reggie Evans",
          number: 30,
          shoe: 14,
          points: 12,
          rebounds: 12,
          assists: 12,
          steals: 12,
          blocks: 12,
          slam_dunks: 7
        },
        {
          player_name: "Brook Lopez",
          number: 11,
          shoe: 17,
          points: 17,
          rebounds: 19,
          assists: 10,
          steals: 3,
          blocks: 1,
          slam_dunks: 15
        },
        {
          player_name: "Mason Plumlee",
          number: 1,
          shoe: 19,
          points: 26,
          rebounds: 11,
          assists: 6,
          steals: 3,
          blocks: 8,
          slam_dunks: 5
        },
        {
          player_name: "Jason Terry",
          number: 31,
          shoe: 15,
          points: 19,
          rebounds: 2,
          assists: 2,
          steals: 4,
          blocks: 11,
          slam_dunks: 1
        }
      ]
    },
    away: {
      team_name: "Charlotte Hornets",
      colors: ["Turquoise", "Purple"],
      players: [
        {
          player_name: "Jeff Adrien",
          number: 4,
          shoe: 18,
          points: 10,
          rebounds: 1,
          assists: 1,
          steals: 2,
          blocks: 7,
          slam_dunks: 2
        },
        {
          player_name: "Bismack Biyombo",
          number: 0,
          shoe: 16,
          points: 12,
          rebounds: 4,
          assists: 7,
          steals: 22,
          blocks: 15,
          slam_dunks: 10
        },
        {
          player_name: "DeSagna Diop",
          number: 2,
          shoe: 14,
          points: 24,
          rebounds: 12,
          assists: 12,
          steals: 4,
          blocks: 5,
          slam_dunks: 5
        },
        {
          player_name: "Ben Gordon",
          number: 8,
          shoe: 15,
          points: 33,
          rebounds: 3,
          assists: 2,
          steals: 1,
          blocks: 1,
          slam_dunks: 0
        },
        {
          player_name: "Kemba Walker",
          number: 33,
          shoe: 15,
          points: 6,
          rebounds: 12,
          assists: 12,
          steals: 7,
          blocks: 5,
          slam_dunks: 12
        }
      ]
    }
  }
end
# =============================================
#               find_points method
# =============================================

def find_points(player_data, player_name)
  if player_data[:player_name] == player_name
    return player_data[:points]
  end
end

# =============================================
#               find_shoe_size method
# =============================================

def find_shoe_size(player_data, players_name)
  if players_name == player_data[:player_name]  
    return player_data[:shoe]
  end
end

# =============================================
#               find_team_colors method
# =============================================

def find_team_colors(find_it, top_level)
  if game_hash[top_level][:team_name] == find_it 
    return game_hash[top_level][:colors]
  end
end

# =============================================
#          find_player_stats method
# =============================================

def find_player_stats(player_data, player_name)
  if player_data[:player_name] == player_name
    return player_data
  end
end

# =============================================
#               find_big_foot method
# =============================================

def find_big_foot
  big_foot = 0
  rebounds = 0
  game_hash.each do |location, team_data|
    team_data[:players].each do |players_data|
      if big_foot < players_data[:shoe]
        big_foot = players_data[:shoe]
        rebounds = players_data[:rebounds]
      end
    end
  end
  return rebounds
end

# =============================================
#             first_tier_team_name method
# =============================================

def first_tier_team_name(find_it)
  team_names = []
  game_hash.map do |location, team_data|
    if !team_names.include?(team_data[find_it])
      team_names.push(team_data[find_it])
    end
  end
  return team_names
end

# =============================================
#             second_tier_colors method
# =============================================

def second_tier_colors(find_it, top_level)
   return find_team_colors(find_it, top_level)
end

# =============================================
#          third_tier_all_players method
# =============================================

def third_tier_all_players(find_it, tier, func)
  response = nil
  game_hash.map do |location, team_data|
    team_data[tier].map do |players_data|
      response = method(func).call(players_data, find_it) 
      if !!response
        return response
      end
    end
  end
  return response
end

# =============================================
#        third_tier_by_team_players method
# =============================================

def third_tier_by_team_players(find_it)
  collect_jersey = []
  game_hash.map do |location, team_data|
    if team_data[:team_name] == find_it
      team_data[:players].each do |player|
        collect_jersey << player[:number]
      end
    end
  end
  return collect_jersey
end

# =============================================
#               select_func method
# =============================================

def select_func(find_it = nil, func)
  tier = ""
  method_array = [:find_points, :find_shoe_size, :find_player_stats]

  if method_array.include?(func)

    tier = :players
    return third_tier_all_players(find_it, tier, func)

  elsif func == :find_team_colors

    find_it == "Charlotte Hornets" ?  top_level = :away : top_level = :home
    return second_tier_colors(find_it, top_level)

  elsif func == :find_team_names

    return first_tier_team_name(find_it)
  
  elsif func == "collect_team_jersey"
    
    tier = :team_name
    return third_tier_by_team_players(find_it)

  elsif func == :find_big_foot 
    
    return method(func).call

  else
    
    return "This method does not exist."
  end
  
end

# =============================================
#               num_points_scored
# =============================================

def num_points_scored(players_name)
  return select_func(players_name, :find_points)
end

# =============================================
#               shoe_size
# =============================================

def shoe_size(players_name)
  return select_func(players_name, :find_shoe_size)
end

# =============================================
#               team_colors
# =============================================

def team_colors(team_name)
  return select_func(team_name, :find_team_colors)
end

# =============================================
#               team_names
# =============================================

def team_names
  return select_func(:team_name, :find_team_names)
end

# =============================================
#               player_numbers
# =============================================

def player_numbers(team_name)
  key_word = "collect_team_jersey"
  return select_func(team_name, key_word)
end

# =============================================
#               player_stats
# =============================================

def player_stats(player)
  return select_func(player, :find_player_stats)
end

# =============================================
#               big_shoe_rebounds
# =============================================

def big_shoe_rebounds
  return select_func(:find_big_foot)
end

