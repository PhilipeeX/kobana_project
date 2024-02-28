require 'rails_helper'

RSpec.describe KobanaRequests::HandleBankBillets do
  let(:valid_params) do
    {
      amount: 190.25,
      expire_at: '2024-10-19',
      customer_person_name: 'Thiago da Silva',
      customer_cnpj_cpf: '01482558092',
      customer_state: 'RJ',
      customer_city_name: 'Rio de Janeiro',
      customer_zipcode: '20751340',
      customer_address: 'Rua Luís Vargas',
      customer_neighborhood: 'Piedade'
    }
  end
  let(:billet_id) do
    response = KobanaRequests::HandleBankBillets.call(:create, valid_params)
    JSON.parse(response.body)['id']
  end

  describe '#call' do
    it 'creates a bank billet with valid parameters on method create_billet', :vcr do
      result = KobanaRequests::HandleBankBillets.call(:create, valid_params)

      expect(result.code).to eq('201')
      body = JSON.parse(result.body)
      expect(body).to include('amount' => 190.25, 'customer_person_name' => 'Thiago da Silva')
    end

    it 'returns expected response for private method index_billets', :vcr do
      result = KobanaRequests::HandleBankBillets.call(:index)

      expect(result).to be_an(Array)
      result.each do |bank_billet|
        expect(bank_billet).to include(
          'id',
          'status',
          'amount',
          'expire_at',
          'customer_person_name',
          'customer_cnpj_cpf',
          'customer_state',
          'customer_city_name',
          'customer_zipcode',
          'customer_address',
          'customer_neighborhood'
        )
      end
    end

    it 'updates a bank billet with valid parameters on method update', :vcr do
      params = {
        id: billet_id,
        amount: 200.0
      }

      result = KobanaRequests::HandleBankBillets.call(:update, params)

      expect(result.code).to eq('204')
      expect(result.body).to be_nil
    end

    it 'cancels a bank billet with valid parameters on method destroy', :vcr do
      result = KobanaRequests::HandleBankBillets.call(:destroy, billet_id)

      expect(result.code).to eq('204')
    end

    it 'returns "Unknown action" message' do
      result = KobanaRequests::HandleBankBillets.call(:unknown_action)

      expect(result).to eq("#{I18n.t('businesses.kobana_requests.unknown_action')}: unknown_action")
    end
  end
end
