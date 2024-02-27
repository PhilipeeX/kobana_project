class BankBilletsController < ApplicationController
  def index
    @billets = KobanaRequests::HandleBankBillets.call(:index)
  end

  def new
  end

  def create
    response = KobanaRequests::HandleBankBillets.call(:create, create_billet_params)
    response_data = BankBilletsHelper.process_response(response.body)

    if response_data[:success]
      redirect_to action: 'index'
    else
      flash[:notice] = response_data[:error_messages]
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @billet_id = params[:id]
  end

  def update
    response = KobanaRequests::HandleBankBillets.call(:update, params[:id], update_billet_params)

    if response.code == '204'
      redirect_to bank_billets_path, notice: 'Boleto atualizado com sucesso'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def show

  end

  private

  def create_billet_params
    params.permit(:amount, :expire_at, :description, :customer_person_name, :customer_cnpj_cpf, :customer_state, :customer_city_name, :customer_zipcode, :customer_address, :customer_neighborhood)
  end

  def update_billet_params
    params.permit(:amount, :expire_at, :description)
  end
end
