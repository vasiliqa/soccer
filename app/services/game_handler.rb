class GameHandler
  def call(data)
    data.each do |item|
      Game.find_or_initialize_by(api_id: item['id']).tap do |game|
        game.date = item['date']
        game.home_team = item['homeTeamName']
        game.away_team = item['awayTeamName']
        if item['result']
          game.home_team_goals = item['result']['goalsHomeTeam']
          game.away_team_goals = item['result']['goalsAwayTeam']
        end
        game.save
      end
    end
  end
end
