require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  render_views

  describe 'GET #home' do
    it 'responds with 200' do
      create :game
      get :home
      expect(response).to have_http_status 200
    end
  end
end
