require 'rails_helper'

RSpec.describe ApiConnector do
  let(:start_date) { 10.days.ago.strftime('%Y-%m-%d') }
  let(:end_date) { 11.days.after.strftime('%Y-%m-%d') }

  describe 'when response code is not 200' do
    it 'returns an error' do
      stub_request(:get,  "http://api.football-data.org/v1/fixtures?league=CL&timeFrameEnd=#{end_date}&timeFrameStart=#{start_date}").
        with(headers: {'X-Response-Control'=>'minified'}).
        to_return(status: [400, 'Bad request'], body: "", headers: {})

      expect(ApiConnector.new.call).to eq(error: 'Bad request')
    end
  end

  describe 'when response code is 200' do
    it 'returns a result' do
      body = "{\"fixtures\":[
        {\"date\":\"2017-10-31T19:45:00Z\",\"status\":\"FINISHED\",\"matchday\":4,
        \"homeTeamName\":\"Club Atlético de Madrid\",\"awayTeamName\":\"Qarabag Agdam FK\",
        \"result\":{\"goalsHomeTeam\":1,\"goalsAwayTeam\":1},\"odds\":null},
        {\"date\":\"2017-10-31T19:45:00Z\",\"status\":\"FINISHED\",\"matchday\":4,
        \"homeTeamName\":\"FC Basel\",\"awayTeamName\":\"CSKA Moscow\",
        \"result\":{\"goalsHomeTeam\":1,\"goalsAwayTeam\":2},\"odds\":null}]}"

      expected_result = {  result: [
        { "date"=>"2017-10-31T19:45:00Z", "status"=>"FINISHED", "matchday"=>4,
        "homeTeamName"=>"Club Atlético de Madrid", "awayTeamName"=>"Qarabag Agdam FK",
        "result"=>{"goalsHomeTeam"=>1, "goalsAwayTeam"=>1}, "odds"=>nil },
        { "date"=>"2017-10-31T19:45:00Z", "status"=>"FINISHED", "matchday"=>4,
        "homeTeamName"=>"FC Basel", "awayTeamName"=>"CSKA Moscow",
        "result"=>{"goalsHomeTeam"=>1, "goalsAwayTeam"=>2}, "odds"=>nil }
      ] }

      stub_request(:get,  "http://api.football-data.org/v1/fixtures?league=CL&timeFrameEnd=#{end_date}&timeFrameStart=#{start_date}").
        with(headers: {'X-Response-Control'=>'minified'}).
        to_return(status: 200, body: body, headers: {})

      expect(ApiConnector.new.call).to eq expected_result
    end
  end
end
