require 'rails_helper'

RSpec.describe GameSyncService do
  context 'when there is an error in api data' do
    it 'calls only ApiConnector' do
      expect_any_instance_of(ApiConnector).to receive(:call).and_return({ error: 'Smth went wrong' })
      expect_any_instance_of(GameHandler).not_to receive(:call)
      GameSyncService.new.call
    end
  end

  context 'when there is no errors' do
    it 'calls both services' do
      expect_any_instance_of(ApiConnector).to receive(:call).and_return({ result: 'Some data goes here' })
      expect_any_instance_of(GameHandler).to receive(:call)
      GameSyncService.new.call
    end
  end
end

