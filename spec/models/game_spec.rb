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

require 'rails_helper'

RSpec.describe Game, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
