Rails.application.routes.draw do
  resources :addresses
  resources :transactions
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    registrations:  'registrations',
    sessions:  'sessions'
  }

  resources :accounts do
    member do
      get 'list_transactions'
      get 'status'
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
