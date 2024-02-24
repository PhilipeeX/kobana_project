# TODO: Remover esse arquivo quando carteira homologada estiver disponível

require 'webmock'
require 'securerandom'

# rubocop:disable Style/MixinUsage
include WebMock::API

WebMock.disable_net_connect!(allow_localhost: true)
WebMock.enable!

stub_request(:get, 'https://api-sandbox.kobana.com.br/v1/bank_billets').to_return do |request|
  {
    status: 200,
    body: Array.new(10) do
      {
        "id": SecureRandom.uuid,
        "status": 'generating',
        "amount": rand(2.00..2600.00).round(2),
        "expire_at": FFaker::Date.forward.strftime('%Y-%m-%d'),
        "customer_person_name": FFaker::NameBR.name,
        "customer_cnpj_cpf": FFaker::IdentificationBR.pretty_cpf,
        "customer_state": FFaker::AddressBR.state_abbr,
        "customer_city_name": FFaker::AddressBR.city,
        "customer_zipcode": FFaker::AddressBR.zip_code,
        "customer_address": FFaker::AddressBR.street,
        "customer_neighborhood": FFaker::AddressBR.neighborhood
      }
    end.to_json,
    headers: { 'Content-Type' => 'application/json' }
  }
end
# rubocop:enable Style/MixinUsage
