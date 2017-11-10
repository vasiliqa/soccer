# == Schema Information
#
# Table name: games
#
#  id              :integer          not null, primary key
#  date            :datetime
#  home_team       :string
#  away_team       :string
#  home_team_goals :integer
#  away_team_goals :integer
#  api_id          :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Game < ApplicationRecord
  def as_json(options={})
    {
      id: id,
      date: date.strftime('%H:%M, %d %B, %Y'),
      home_team: home_team,
      away_team: away_team,
      home_team_goals: home_team_goals,
      away_team_goals: away_team_goals
    }
  end
end
