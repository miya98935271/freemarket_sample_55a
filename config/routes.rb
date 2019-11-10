Rails.application.routes.draw do 
  devise_for :users

  root 'products#index'
  
  resources :users, only: [:index,:edit] do
    collection do
      get :user_identification
    end
  end

  resources :products do
    collection do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
    end
    member do
      get :item
    end
  end 

  resources :creditcards, only: [:index, :destroy]
  get 'logout' => "users#logout"
  get 'login', to: 'registrations#login'
  get 'buy', to: 'products#buy'
  
  resources :registrations do
    collection do
      get  'step1'
      get  'step2'
      get  'step3'
      get  'step4'
      get  'step5'
      get  'step6'
    end
  end
end

