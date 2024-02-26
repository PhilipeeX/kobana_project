require 'rails_helper'

RSpec.describe BankBilletsController, type: :controller do
  render_views
  describe 'GET #index' do
    it 'returns a success response', :vcr do
      get :index
      expect(response).to be_successful
    end

    it 'assigns @billets', :vcr do
      get :index
      expect(assigns(:billets)).to be_an(Array)
    end
  end
end
