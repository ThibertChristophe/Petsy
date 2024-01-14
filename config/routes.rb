Rails.application.routes.draw do
  resources :users do
    # va generer une route /:id/confirm
    member do
      get 'confirm'
    end
  end
  root 'users#new'
end
