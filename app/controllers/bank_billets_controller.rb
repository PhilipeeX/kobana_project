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
      flash.now[:success] = t('.create')
      redirect_to bank_billets_path
    else
      flash.now[:error] = response_data[:error_messages]
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    session[:billet_id] = params[:id]
  end

  def update
    response = KobanaRequests::HandleBankBillets.call(:update, billet_params)
    response_data = BankBilletsHelper.process_update_response(response)

    if response_data[:success]
      session.delete(:billet_id)
      redirect_to bank_billets_path, flash: { success: t('.update') }
    else
      flash.now[:error] = response_data[:error_messages]
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    response = KobanaRequests::HandleBankBillets.call(:destroy, params[:id])
    if response.code == '204'
      flash.now[:success] = t('.cancel_success')
    else
      flash.now[:error] = t('.cancel_failure')
    end
    redirect_to bank_billets_path
  end

  private

  def billet_params
    params.permit(:id, :amount, :expire_at, :description, :customer_person_name, :customer_cnpj_cpf, :customer_state, :customer_city_name, :customer_zipcode, :customer_address,
                  :customer_neighborhood)
  end
end
