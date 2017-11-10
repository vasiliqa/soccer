require 'rails_helper'

RSpec.describe GameHandler do
  let (:data)  { [
    { "id" => 164762,
    "competitionId" => 464,
    "date" => "2017-10-31T19:45:00Z",
    "status" => "FINISHED",
    "matchday" => 4,
    "homeTeamName" => "Club Atlético de Madrid",
    "homeTeamId" => 78,
    "awayTeamName" => "Qarabag Agdam FK",
    "awayTeamId" => 611,
    "result" => {"goalsHomeTeam" => 1, "goalsAwayTeam" => 1},
    "odds" => nil }
  ] }

  let (:expected_attrs) { {
    date: '2017-10-31 19:45:00 +0000'.to_time,
    home_team: "Club Atlético de Madrid",
    away_team: "Qarabag Agdam FK",
    home_team_goals: 1,
    away_team_goals: 1,
    api_id: 164762
  } }

  context 'when a game does not exist' do
    it 'creates a new game' do
      expect {GameHandler.new.call(data)}.to change{Game.count}.by(1)
      expect(Game.last).to have_attributes(expected_attrs)
    end
  end

  context 'when a game already exists' do
    it 'updated the game' do
      game = create :game,
        date: '2017-10-31 19:45:00 +0000',
        home_team: "Club Atlético de Madrid",
        away_team: "Qarabag Agdam FK",
        home_team_goals: 0,
        away_team_goals: 0,
        api_id: 164762

      expect {GameHandler.new.call(data)}.to change{game.reload.home_team_goals}.from(0).to(1).
        and change{game.reload.away_team_goals}.from(0).to(1)
      expect {GameHandler.new.call(data)}.not_to change{Game.count}
      expect(game).to have_attributes(expected_attrs)
    end
  end
end
