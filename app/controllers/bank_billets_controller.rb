class BankBilletsController < ApplicationController
  def index
    @billets = KobanaRequests::HandleBankBillets.call(:index)
  end

  def new
  end

  def create
    response = KobanaRequests::HandleBankBillets.call(:create, billet_params)
    response_data = BankBilletsHelper.process_response(response.body)

    if response_data[:success]
      redirect_to action: 'index'
    else
      flash[:notice] = response_data[:error_messages]
      render :new, status: :unprocessable_entity
    end
  end

  private

  def billet_params
    params.permit(:amount, :expire_at, :customer_person_name, :customer_cnpj_cpf, :customer_state, :customer_city_name, :customer_zipcode, :customer_address, :customer_neighborhood)
  end
end
