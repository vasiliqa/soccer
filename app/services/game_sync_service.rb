class GameSyncService
  def call
    data = ApiConnector.new.call
    return Rails.logger.error data[:error] if data[:error]

    GameHandler.new.call(data[:result])
  end
end
