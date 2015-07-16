require 'rails_helper'

module Peephole
  RSpec.describe WelcomeController, type: :controller do
    render_views
    routes { Engine.routes }

    describe '#index' do
      it 'returns http success' do
        get :index
        expect(response).to have_http_status(:success)
      end
    end
  end
end
