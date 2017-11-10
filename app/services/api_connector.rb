class ApiConnector
  def initialize
    @base_url = 'http://api.football-data.org/v1/fixtures'
    @league = 'CL'
    @start_date = 10.days.ago.strftime('%Y-%m-%d')
    @end_date = 11.days.after.strftime('%Y-%m-%d')
  end

  def call
    response = HTTParty.get(
      "#{base_url}?league=#{league}&timeFrameStart=#{start_date}&timeFrameEnd=#{end_date}",
      headers: { 'X-Response-Control' => 'minified' }
    )
    return { error: response.message } unless response.code == 200

    { result: JSON.parse(response.body)['fixtures'] }
  rescue JSON::ParserError => e
    return { error: e }
  end

  private

  attr_reader :base_url, :league, :start_date, :end_date
end
