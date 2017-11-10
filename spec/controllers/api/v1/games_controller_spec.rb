require 'rails_helper'

RSpec.describe Api::V1::GamesController, type: :controller do
  render_views

  describe 'GET #index' do
    it 'responds with json' do
      game = create :game, date: '2017-11-11 17:00:00 +0000'
      game1 = create :game, date: '2017-11-10 13:00:00 +0000'
      get :index

      expected_body = [
        { "id"=>game1.id, "date"=>"13:00, 10 November, 2017",
          "home_team"=>"MyString", "away_team"=>"MyString",
          "home_team_goals"=>1, "away_team_goals"=>1 },
        { "id"=>game.id, "date"=>"17:00, 11 November, 2017",
          "home_team"=>"MyString", "away_team"=>"MyString",
          "home_team_goals"=>1, "away_team_goals"=>1 }
      ]
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json')
      expect(JSON.parse(response.body)).to eq(expected_body)
    end
  end
end
