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
      { success: false, error_messages: I18n.t('bank_billets_helper.error_message') }
    end
  end

  def self.process_update_response(response)
    if response.code == '204'
      { success: true }
    elsif response.body.present?
      errors = JSON.parse(response.body)['errors']
      error_messages = errors.map do |field, messages|
        "#{field}: #{messages.join(', ')}"
      end
      { success: false, error_messages: error_messages.join('. ') }
    else
      { success: false, error_messages: I18n.t('bank_billets_helper.error_message') }
    end
  end

  def self.state_options
    [
      ['Todos os estados', 'all'],
      %w[Acre AC],
      %w[Alagoas AL],
      %w[Amapá AP],
      %w[Amazonas AM],
      %w[Bahia BA],
      ['Ceará', 'CE'],
      ['Distrito Federal', 'DF'],
      ['Espírito Santo', 'ES'],
      ['Goiás', 'GO'],
      ['Maranhão', 'MA'],
      ['Mato Grosso', 'MT'],
      ['Mato Grosso do Sul', 'MS'],
      ['Minas Gerais', 'MG'],
      ['Pará', 'PA'],
      ['Paraíba', 'PB'],
      ['Paraná', 'PR'],
      ['Pernambuco', 'PE'],
      ['Piauí', 'PI'],
      ['Rio de Janeiro', 'RJ'],
      ['Rio Grande do Norte', 'RN'],
      ['Rio Grande do Sul', 'RS'],
      ['Rondônia', 'RO'],
      ['Roraima', 'RR'],
      ['Santa Catarina', 'SC'],
      ['São Paulo', 'SP'],
      ['Sergipe', 'SE'],
      ['Tocantins', 'TO']
    ]
  end
end
