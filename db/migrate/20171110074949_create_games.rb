class CreateGames < ActiveRecord::Migration[5.1]
  def change
    create_table :games do |t|
      t.datetime :date
      t.string :home_team
      t.string :away_team
      t.integer :home_team_goals
      t.integer :away_team_goals
      t.integer :api_id, index: true

      t.timestamps
    end
  end
end
