require 'rails_helper'
require 'webmock/rspec'

RSpec.describe KobanaRequests::HandleBankBillets do
  describe '#call' do
    it 'returns expected response for private method index_billets' do
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
    it 'returns "Unknown action" message' do
      result = KobanaRequests::HandleBankBillets.call(:unknown_action)

      expect(result).to eq("#{I18n.t('businesses.kobana_requests.unknown_action')}: unknown_action")
    end
  end
end
