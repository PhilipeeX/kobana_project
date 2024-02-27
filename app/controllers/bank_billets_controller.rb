class BankBilletsController < ApplicationController
  def index
    @billets = KobanaRequests::HandleBankBillets.call(:index)
  end

  def new
  end

  def create
    response = KobanaRequests::HandleBankBillets.call(:create, billet_params)
    if JSON.parse(response.body)['status'] == 'generating'
      redirect_to action: 'index'
    elsif JSON.parse(response.body).include? 'errors'
      errors = JSON.parse(response.body)['errors']
      error_messages = errors.map do |field, messages|
        "#{field}: #{messages.join(', ')}"
      end
      flash[:notice] = "Esses erros impediram a criação do boleto: #{error_messages.join('. ')}"
      render :new, status: :unprocessable_entity
    end
  end

  private

  def billet_params
    params.permit(:amount, :expire_at, :customer_person_name, :customer_cnpj_cpf, :customer_state, :customer_city_name, :customer_zipcode, :customer_address, :customer_neighborhood)
  end
end
