Rails.application.routes.draw do
  get 'bank_billets', to: 'bank_billets#index', as: :bank_billets
  get 'bank_billets/new', to: 'bank_billets#new', as: :new_bank_billet
  post 'bank_billets/create', to: 'bank_billets#create', as: :create_bank_billets

  get 'up' => 'rails/health#show', as: :rails_health_check
end
