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

  let(:billet_id) do
    response = KobanaRequests::HandleBankBillets.call(:create, valid_params)
    JSON.parse(response.body)['id']
  end

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

  describe 'PUT #update' do
    it 'updates bank_billets and returns status 302', :vcr do
      put :update, params: { id: billet_id, amount: 250.55 }

      expect(response.status).to eq 302
      expect(response).to redirect_to(bank_billets_path)
      expect(flash[:notice]).to eq(I18n.t('bank_billets.update'))
    end

    xit 'doesnt update bank_billets with invalid params', :vcr do
      put :update, params: { id: billet_id, amount: 320.40, expire_at: '' }

      expect(response).to have_http_status(422)
      expect(response).to render_template('edit')
    end
  end

  describe 'PUT #destroy' do
    it 'cancel bank_billet and returns status 302', :vcr do
      delete :destroy, params: { id: billet_id }

      expect(response.status).to eq 302
      expect(response).to redirect_to(bank_billets_path)
      expect(flash[:notice]).to eq(I18n.t('bank_billets.cancel_success'))
    end
  end
end
