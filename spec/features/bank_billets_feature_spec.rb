require 'rails_helper'

RSpec.xfeature 'Bank Billets', type: :feature do
  valid_params = {
    amount: rand(100),
    expire_at: '2024-10-19',
    customer_person_name: FFaker::NameBR.name,
    customer_cnpj_cpf: '01482558092',
    customer_state: 'RJ',
    customer_city_name: 'Rio de Janeiro',
    customer_zipcode: '20751340',
    customer_address: 'Rua Luís Vargas',
    customer_neighborhood: 'Piedade'
  }

  before(:each) do
    response = KobanaRequests::HandleBankBillets.call(:create, valid_params)
    @billet = JSON.parse(response.body)
  end

  scenario 'list bank_billets' do
    VCR.use_cassette('bank_billets_index') do
      visit bank_billets_path

      expect(page).to have_text(valid_params[:customer_person_name])
    end
  end
end
