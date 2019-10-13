Rails.application.routes.draw do
  root 'products#index'
  resources :products,only: [:index, :new]
  resources :users,only: 'index'
  get 'step1', to: 'registrations#step1'
  get 'step2', to: 'registrations#step2'
  get 'step3', to: 'registrations#step3'
  get 'step4', to: 'registrations#step4'
  get 'step5', to: 'registrations#step5'
  get 'step6', to: 'registrations#step6'
  get 'login', to: 'registrations#login'
end
