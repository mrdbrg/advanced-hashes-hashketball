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

def find_points(player_data, players_name)
    if players_name == player_data[:player_name]
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

def find_team_colors(team_data, find_it)
  team_data[:team_name] == find_it ? team_data[:colors] : "Ops! I can't find their colors"
end

# =============================================
#               find_team_name method
# =============================================

def find_team_name(team_data, find_it)
  team_names = []
  !team_names.include?(team_data[find_it]) ? team_names.push(team_data[find_it]) : "Ops! I can't find their names."
end

# =============================================
#             first_tier_team_name method
# =============================================

def first_tier_team_name(find_it)
  game_hash.map do |location, team_data|
    return find_team_name(team_data, find_it)
  end
  return team_names
end

# =============================================
#             second_tier_colors method
# =============================================

def second_tier_colors(find_it)
  game_hash.map do |location, team_data|
    return find_team_colors(team_data, find_it)
  end
end

# =============================================
#             third_tier_players method
# =============================================

def third_tier_players(find_it, tier, func)
  response = nil
  game_hash.map do |location, team_data|
    team_data[tier].map do |players_data|
      response = method(func).call(players_data, find_it) 
      if response
        return response
      end
    end
  end
  return response
end

# =============================================
#               tear_down method
# =============================================

def tear_down(find_it, func)
  tier = ""
  method_array = [:find_points, :find_shoe_size]

  if method_array.include?(func)

    tier = :players
    return third_tier_players(find_it, tier, func)

  elsif func == :find_team_colors

    return second_tier_colors(find_it)

  elsif func == :find_team_name
    
    return first_tier_team_name(find_it)

  else
    return "Sorry! That method does not exist. Please, try again."
  end
  
end

# =============================================
#               team_names
# =============================================

def team_names(t_names)
  t_names = :team_name
  return tear_down(t_names, :find_team_name)
end

p team_names("team names")
# "Brooklyn Nets", "Charlotte Hornets"

# =============================================
#               num_points_scored
# =============================================

def num_points_scored(players_name)
  return tear_down(players_name, :find_points)
end

p num_points_scored("Jeff Adrien")
# # 10

# =============================================
#               shoe_size
# =============================================

def shoe_size(players_name)
  return tear_down(players_name, :find_shoe_size)
end

# p shoe_size("Jeff Adrien")

# =============================================
#               team_colors
# =============================================

def team_colors(team_name)
  return tear_down(team_name, :find_team_colors)
end

p team_colors("Brooklyn Nets")
# "Black", "White"
