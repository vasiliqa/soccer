class Api::V1::GamesController < ApplicationController
  def index
    games = Game.all.order(date: :asc)
    render json: games
  end
end
