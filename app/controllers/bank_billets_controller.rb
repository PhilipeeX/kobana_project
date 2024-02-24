class BankBilletsController < ApplicationController

  def index
    @billets = KobanaRequests::HandleBankBillets.call(:index)
  end
end
