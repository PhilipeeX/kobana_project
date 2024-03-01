Rails.application.routes.draw do
  root 'bank_billets#index'
  resources :bank_billets

  get 'up' => 'rails/health#show', as: :rails_health_check
end
