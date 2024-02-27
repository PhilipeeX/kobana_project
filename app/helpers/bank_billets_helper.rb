# Handles bank billets
module BankBilletsHelper
  def self.process_response(response_body)
    parsed_response = JSON.parse(response_body)

    if parsed_response['status'] == 'generating'
      { success: true }
    elsif parsed_response.include?('errors')
      errors = parsed_response['errors']
      error_messages = errors.map do |field, messages|
        "#{field}: #{messages.join(', ')}"
      end
      { success: false, error_messages: error_messages.join('. ') }
    else
      { success: false, error_messages: 'Erro desconhecido ao processar a resposta da API.' }
    end
  end
end