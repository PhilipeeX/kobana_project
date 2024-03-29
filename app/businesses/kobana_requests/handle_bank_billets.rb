module KobanaRequests
  # This \class Handles requests for bank billets which comes from kobana api
  class HandleBankBillets < BusinessApplication
    def initialize(action, params = {})
      @action = action
      @params = params
    end

    def call
      case @action
      when :index
        request_api(:get, 'https://api-sandbox.kobana.com.br/v1/bank_billets')
      when :create
        request_api(:post, 'https://api-sandbox.kobana.com.br/v1/bank_billets', @params)
      when :update
        request_api(:put, "https://api-sandbox.kobana.com.br/v1/bank_billets/#{@params[:id]}", @params)
      when :destroy
        request_api(:put, "https://api-sandbox.kobana.com.br/v1/bank_billets/#{@params}/cancel")
      else
        "#{I18n.t('businesses.kobana_requests.unknown_action')}: #{@action}"
      end
    end

    private

    def request_api(method, url, body = nil)
      uri = URI(url)
      http = create_http(uri)
      request = create_request(method, uri, body)

      response = http.request(request)
      method == :get ? JSON.parse(response.body) : response
    end

    def create_http(uri)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http
    end

    def create_request(method, uri, body)
      request = create_http_request(method, uri)
      request_headers(request)
      request_body(request, method, body) if [:post, :put].include?(method)
      request
    end

    def create_http_request(method, uri)
      case method
      when :get
        Net::HTTP::Get.new(uri)
      when :post
        Net::HTTP::Post.new(uri)
      when :put
        Net::HTTP::Put.new(uri)
      end
    end

    def request_headers(request)
      request['accept'] = 'application/json'
      request['authorization'] = "Bearer #{ENV['KOBANA_ACCESS_TOKEN']}"
    end

    def request_body(request, _method, body)
      request['content-type'] = 'application/json'
      request.body = body.to_json
    end
  end
end
