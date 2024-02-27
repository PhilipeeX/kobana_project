require 'rails_helper'

RSpec.describe BankBilletsController, type: :controller do
  render_views
  valid_params = {
    amount: 84.0,
    expire_at: '2024-10-19',
    customer_person_name: 'Thiago da Silva',
    customer_cnpj_cpf: '01482558092',
    customer_state: 'RJ',
    customer_city_name: 'Rio de Janeiro',
    customer_zipcode: '20751340',
    customer_address: 'Rua Luís Vargas',
    customer_neighborhood: 'Piedade'
  }

  invalid_billet_params = {
    amount: nil,
    expire_at: '',
    customer_person_name: 'Thiago da Silva',
    customer_cnpj_cpf: '01482558092',
    customer_state: 'RJ',
    customer_city_name: 'Rio de Janeiro',
    customer_zipcode: '20751340',
    customer_address: 'Rua Luís Vargas',
    customer_neighborhood: 'Piedade'
  }

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new BankBillet and redirects to index', :vcr do
        post :create, params: valid_params
        expect(response).to redirect_to(action: 'index')
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new BankBillet and renders new', :vcr do
        post :create, params: invalid_billet_params

        expect(response).to render_template(:new)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

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
