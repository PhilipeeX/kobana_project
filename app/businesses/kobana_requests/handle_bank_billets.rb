module KobanaRequests
  # This \class Handles requests for bank billets which comes from kobana api
  class HandleBankBillets < BusinessApplication
    def initialize(action, params = {})
      @action = action
      @params = params
    end

    def call
      if @action == :index
        index_billets
      elsif @action == :create
        create_bank_billet
      else
        "#{I18n.t('businesses.kobana_requests.unknown_action')}: #{@action}"
      end
    end

    private

    def index_billets
      url = URI('https://api-sandbox.kobana.com.br/v1/bank_billets')

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true

      request = Net::HTTP::Get.new(url)
      request['accept'] = 'application/json'
      request['authorization'] = "Bearer #{Rails.application.credentials.dig(:api, :boletosimples, :access_token)}"

      response = http.request(request)
      JSON.parse(response.body)
    end

    def create_bank_billet
      url = URI('https://api-sandbox.kobana.com.br/v1/bank_billets')

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true

      request = Net::HTTP::Post.new(url)
      request['accept'] = 'application/json'
      request['content-type'] = 'application/json'
      request['authorization'] = "Bearer #{Rails.application.credentials.dig(:api, :boletosimples, :access_token)}"
      request.body = @params.to_json

      http.request(request)
    end
  end
end
