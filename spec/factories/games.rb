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

FactoryBot.define do
  factory :game do
    date 1.day.ago
    home_team "MyString"
    away_team "MyString"
    home_team_goals 1
    away_team_goals 1
    api_id 12
  end
end
